package states;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Color;
import luxe.Vector;
import luxe.Camera;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.constraint.PivotJoint;

import nape.space.Space;

import luxe.physics.nape.DebugDraw;

import C;

class Play extends State {

	public static var drawer: DebugDraw;
	public static var debugText: luxe.Text;

	public static var borders: Body;
	public static var covers: Body;

	var azur: entity.Azur; // Left fighter

	override public function onenter<T> (_:T) {
		drawer = new DebugDraw();
		debugText = new luxe.Text({name: 'debug', pos: new Vector(200, 20)});
        Luxe.physics.nape.debugdraw = drawer;

		setupWorld();
		spawnPlayers();

	}

	function setupWorld() {
		// Reset space with no gravity
		Luxe.physics.nape.space = new Space( new Vec2(0, 0));
		Luxe.physics.nape.space.worldLinearDrag = 2;
		Luxe.physics.nape.space.worldAngularDrag = 2.4;

		// nape.Config.linearSleepThreshold = 10;

		// Create four boundary walls for gameplay arena
		borders = new Body ( BodyType.STATIC );
		borders.shapes.add(new Polygon(Polygon.rect(0, 0, Main.w, -1)));
		borders.shapes.add(new Polygon(Polygon.rect(0, Main.h, Main.w, 1)));
		borders.shapes.add(new Polygon(Polygon.rect(0, 0, -1, Main.h)));
		borders.shapes.add(new Polygon(Polygon.rect(Main.w, 0, 1, Main.h)));

		// borders.setShapeMaterials(nape.phys.Material.rubber());
		borders.setShapeMaterials(new nape.phys.Material(1.0, 1.0, 2.0, 1.0, 0.1));
		borders.space = Luxe.physics.nape.space;
		drawer.add(borders);

		spawnCovers();

	}

	function spawnPlayers() {

		azur = new entity.Azur();
		// Creating and arming Azur
		// azur = new Body(BodyType.DYNAMIC);
		// azur.shapes.add(new Polygon(Polygon.box(32, 64)));
		// azur.position.setxy(Main.w * 0.25, Main.h * 0.5);
		// azur.space = Luxe.physics.nape.space;
		// drawer.add(azur);

		// azur.add(new component.LeftTouchControl());
	}

	function spawnOdeon() {

	}

	function spawnCovers() {
		// Objects that act as cover and obstacles that shards will also bounce off from
		covers = new Body (BodyType.STATIC);
		covers.space = Luxe.physics.nape.space;
		drawer.add(covers);
	}

	override public function update(dt: Float) {

	}

	override public function onleave<T> (_:T) {

	}

	override public function onmousemove(e: MouseEvent) {

		// var desRot = Math.atan2(e.yrel * 100, e.xrel * 100);
		// var desRot = Math.atan2(azur.physic.body.velocity.y, azur.physic.body.velocity.x);
		// Luxe.draw.text({
		// 	text: '${desRot}',
		// 	pos: new Vector(200, 20),
		// 	point_size: 48,
		// 	align: right,
		// 	immediate: true,
		// });

		// debugText.text = Std.string(desRot);
		// debugText.text = Std.string(azur.physic.body.angularVel);
		// debugText.text = Std.string(azur.physic.body.rotation);
	}

	override function onkeyup( e:KeyEvent ) {
		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}
	}
}
