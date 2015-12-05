package states;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Color;
import luxe.Vector;
import luxe.Camera;
import luxe.Text;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.constraint.PivotJoint;

import nape.space.Space;

import luxe.physics.nape.DebugDraw;

import particle.Spark;
import particle.Explosion;
import prop.Essence;

import C;

class Play extends State {

	public static var drawer: DebugDraw;
	public static var debugText: luxe.Text;

	public static var borders: Body;
	public static var covers: Body;

	public static var spark: particle.Spark;
	public static var demom: particle.Explosion;
	public static var essence: particle.Essence;

	public static var lastDeath: Float; // last death of an farger, to check for draw
	public static var arqueAchieved: Bool;
	public static var matchResolved: Bool; // final result is out, will no longer change or enable new result state

	public static var end_scene: luxe.Scene;
	public static var end_winner: luxe.Text;
	public static var end_arque: luxe.Text;
	public static var end_reset: luxe.Sprite;

	var azur: entity.Azur; // Left fighter
	var odeo: entity.Odeo; // Right fighter

	override public function onenter<T> (_:T) {
		// drawer = new DebugDraw();
		debugText = new luxe.Text({name: 'debug', pos: new Vector(200, 20)});
        Luxe.physics.nape.debugdraw = drawer;

        lastDeath = 0;
        arqueAchieved = false;
        matchResolved = false;

		setupWorld();
		spawnPlayers();
		setupCrew();

		setupEvents();
		setupResultScreen();
	}

	function setupWorld() {
		// Reset space with no gravity
		Luxe.physics.nape.space = new Space( new Vec2(0, 0));
		Luxe.physics.nape.space.worldLinearDrag = 2;
		Luxe.physics.nape.space.worldAngularDrag = 2.4;

		// Create four boundary walls for gameplay arena
		borders = new Body ( BodyType.STATIC );
		borders.shapes.add(new Polygon(Polygon.rect(0, 0, Main.w, -1)));
		borders.shapes.add(new Polygon(Polygon.rect(0, Main.h, Main.w, 1)));
		borders.shapes.add(new Polygon(Polygon.rect(0, 0, -1, Main.h)));
		borders.shapes.add(new Polygon(Polygon.rect(Main.w, 0, 1, Main.h)));
		borders.cbTypes.add(PhysTypes.border);

		borders.setShapeMaterials(new nape.phys.Material(1.0, 1.0, 2.0, 1.0, 0.1));
		borders.space = Luxe.physics.nape.space;
		if(states.Play.drawer != null) drawer.add(borders);

		spawnCovers();

	}

	function spawnPlayers() {
		azur = new entity.Azur();
		odeo = new entity.Odeo();
	}

	function spawnCovers() {
		// Objects that act as cover and obstacles that shards will also bounce off from
		covers = new Body (BodyType.STATIC);
		covers.space = Luxe.physics.nape.space;
		if(states.Play.drawer != null) drawer.add(covers);
	}

	function setupCrew() {
		spark = new particle.Spark();
		demom = new particle.Explosion();
		essence = new particle.Essence();
	}

	function setupEvents(){

		// camera shake is performed from entity.PlayerBase

		Luxe.events.listen('effect.spark', function(_e: EffectEvent) {
			spark.flash(_e.pos); // _e.direction == null
		});

		Luxe.events.listen('effect.explosion', function(_e: EffectEvent) {
			demom.flash(_e.pos);
		});

		Luxe.events.listen('effect.essence', function(_e: EffectEvent) {
			essence.flash(_e.pos);
		});

		Luxe.events.listen('effect.essence.drip', function(_e: EffectEvent) {
			var newpos = new Vector( // Create a new vector with randomized variances
				_e.pos.x + Luxe.utils.random.float(-C.essence_pos_variance, C.essence_pos_variance),
				_e.pos.y + Luxe.utils.random.float(-C.essence_pos_variance, C.essence_pos_variance)
			);
			var newscale = Luxe.utils.random.float(C.essence_scale_min, C.essence_scale_max);

			var ess = new Essence(newpos, new Vector(newscale, newscale));
		});

		Luxe.events.listen('effect.essence.splash', function(_e: EffectEvent) {
			// _e.direction is taken as a radian

			var amt = Luxe.utils.random.int(C.essence_splash_amt_min, C.essence_splash_amt_max);

			for (i in 0...amt) {
				// Base stat which will determine essence's size and distance from source
				var stat = Luxe.utils.random.float(1, 5);

				var newscale_vec = new Vector(1/stat, 1/stat);

				// All to determine the randomized position of the essence drop
				// nape.phys.body.rotation is already in radian
				var newdirection = _e.direction + Luxe.utils.random.float(-C.essence_direction_variance, C.essence_direction_variance);
				// var radian = newdirection * Math.PI / 180;
				var newpos = new Vector(
					_e.pos.x + C.essence_splash_dist_figure * Math.cos(newdirection) * stat,
					_e.pos.y + C.essence_splash_dist_figure * Math.sin(newdirection) * stat
				);

				var ess = new Essence(newpos, newscale_vec);
			}
		});

		Luxe.events.listen('effect.essence.splash.heavy', function(_e: EffectEvent) {
			// _e.direction is taken as a radian

			var amt = Luxe.utils.random.int(C.essence_splash_heavy_amt_min, C.essence_splash_heavy_amt_max);

			for (i in 0...amt) { // refer to above events for more details
				var stat = Luxe.utils.random.float(0.5, 7);
				var newscale_vec = new Vector(1/stat, 1/stat);
				var direction = Luxe.utils.random.float(-Math.PI * 2, Math.PI * 2); // covers 360 degrees
				var newpos = new Vector(
					_e.pos.x + C.essence_splash_dist_figure * Math.cos(direction) * stat,
					_e.pos.y + C.essence_splash_dist_figure * Math.sin(direction) * stat
				);

				var ess = new Essence(newpos, newscale_vec);
			}
		});

		// Ending
		Luxe.events.listen('azur.died', function(e){
			if (!matchResolved) {
				// if (Main.state.enabled('end')) Main.state.disable('end'); // dirty hack/ workaround
				// Main.state.enable('end', {azurwins: false, arque: arqueAchieved});
				end_winner.text = 'odeo wins!';
				MatchEnding();
			}
		});

		Luxe.events.listen('odeo.died', function(e){
			if (!matchResolved) {
				// if (Main.state.enabled('end')) Main.state.disable('end');
				// Main.state.enable('end', {azurwins: true, arque: arqueAchieved});
				end_winner.text = 'azur wins!';
				MatchEnding();
			}
		});

		Luxe.events.listen('arque!', function (e){
			arqueAchieved = true;
		});

	}

	function MatchEnding() {
		CheckForDraw(); // if the other is already dead within the timeframe, 'draw' text is drawn
		end_winner.visible = true; // reveal the result text
		if (arqueAchieved) end_arque.visible = true;

		lastDeath = Luxe.time; // assign the time of death for detection of draw (two deaths within C.draw_allowance)
		Luxe.timer.schedule(C.draw_allowance, function(){ // conclude the match and allow restart
			matchResolved = true;
			end_reset.visible = true; // reveal the restart button
		});
	}

	function CheckForDraw() {
		if (lastDeath != 0 && (Luxe.time - lastDeath) < C.draw_allowance) {
			// Luxe.events.fire('end.draw');
			end_winner.text = 'draw';
		}
	}

	// // #debug
	// override public function update(dt: Float) {
	// 	Luxe.draw.text({
	// 		text: '${matchResolved}',
	// 		pos: new Vector(20, 20),
	// 		point_size: 48,
	// 		immediate: true,
	// 		depth: 20,
	// 		color: new Color().rgb(0xdddddd),
	// 	});
	// }

	override public function onleave<T> (_:T) {
		Luxe.scene.empty();
		end_scene.empty();
		end_scene.destroy();
		if(states.Play.drawer != null)  drawer.destroy();

		Luxe.events.clear();
	}

	// #DebugArea
	// override public function onmousemove(e: MouseEvent) {

	// 	// var desRot = Math.atan2(e.yrel * 100, e.xrel * 100);
	// 	// var desRot = Math.atan2(azur.physic.body.velocity.y, azur.physic.body.velocity.x);
	// 	// Luxe.draw.text({
	// 	// 	text: '${desRot}',
	// 	// 	pos: new Vector(200, 20),
	// 	// 	point_size: 48,
	// 	// 	align: right,
	// 	// 	immediate: true,
	// 	// });

	// 	// debugText.text = Std.string(desRot);
	// 	// debugText.text = Std.string(azur.physic.body.angularVel);
	// 	// debugText.text = Std.string(azur.physic.body.rotation);
	// }

	// override public function onmousedown(e: MouseEvent) {
	// 	// spark.flash(e.pos);
	// 	// Luxe.events.fire('effect.spark', {pos: e.pos});
	// 	// Luxe.events.fire('effect.explosion', {pos: e.pos});
	// 	// Luxe.events.fire('effect.essence.drip', {pos: e.pos});
	// }

	override function onkeyup( e:KeyEvent ) {
		if(e.keycode == Key.space) {
			Main.state.enable('end', {azurwins: true, arque: arqueAchieved});
		} else if (e.keycode == Key.key_t) {
			Luxe.events.fire('end.draw');
			trace ('end.draw');
		}
	}

	// END SCREEN STUFF

	function setupResultScreen() {
		end_scene = new luxe.Scene('endScene');

		end_winner = new Text ({
			name: 'r.winner',
			// name_unique: true, // [workaround/dirty hack] to prevent this from being trapped in limbo with another of the same name, since many will be created in one session
			pos: new Vector(Main.w * 0.5, Main.h * 0.2),
			text: 'result',
			align: center,
			align_vertical: center,
			point_size: 96,
			visible: false,
			// visible: true,
			scene: end_scene,
		});

		end_arque = new Text ({
			name: 'r.arque',
			// name_unique: true,
			pos: new Vector(Main.w * 0.5, Main.h * 0.4),
			text: 'arque!',
			align: center,
			align_vertical: center,
			point_size: 96,
			visible: false,
			// visible: true,
			scene: end_scene,
		});

		end_reset = new Sprite ({
			name: 'b.reset',
			// name_unique: true,
			pos: new Vector (Main.w * 0.5, Main.h * 0.7),
			size: new Vector (128, 128),
			visible: false,
			// visible: true,
			scene: end_scene,
			texture: Luxe.resources.texture('assets/button_reset.png'),
		});
	}

	override public function onmousedown(e: MouseEvent) {
		if (!matchResolved) return;
		if (end_reset.point_inside(Luxe.camera.screen_point_to_world(e.pos))) {
			Main.state.set('play');
		}
	}
}

typedef EffectEvent = {
	pos: Vector,
	direction: Float,
}
