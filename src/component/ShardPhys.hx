package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Circle;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;
import C;

// This is not based on component.ArmBase.hx, despite being very similar
// Too tired to find a way to intuitively implement that
class ShardPhys extends Component {

	public var body: Body;
	public var hitFargerCallback: InteractionListener;
	public var hitArmletCallback: InteractionListener;
	public var hitArquenCallback: InteractionListener;
	public var hitBorderCallback: InteractionListener;

	override public function new() {
		super({name: 'physic'});

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Circle(C.shard_radius));
		body.setShapeMaterials(new Material(1.0, 0.1, 1, 0.05, 0.1));
		body.cbTypes.add(PhysTypes.shard);
		body.space = Luxe.physics.nape.space;

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		//Collision callbacks
		hitFargerCallback = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.shard,
			PhysTypes.farger,
			hitFarger
		);
		Luxe.physics.nape.space.listeners.add(hitFargerCallback);

		hitArmletCallback = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.shard,
			PhysTypes.armlet,
			hitArmlet
		);
		Luxe.physics.nape.space.listeners.add(hitArmletCallback);

		hitArquenCallback = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.shard,
			PhysTypes.arquen,
			hitArquen
		);
		Luxe.physics.nape.space.listeners.add(hitArquenCallback);

		hitBorderCallback = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.shard,
			PhysTypes.border,
			hitBorder
		);
		Luxe.physics.nape.space.listeners.add(hitBorderCallback);
	}

	function hitFarger(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {
			hostDestroy();
		}
	}

	// Current mechanic: bounce against shield, destroyed against undetached armlet
	function hitArmlet(callback: InteractionCallback) {

	}

	function hitArquen(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {
			hostDestroy();
		}
	}

	function hitBorder(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {
			var rando = Luxe.utils.random.int(1,5);
			switch rando {
				case 1: Luxe.audio.play('border_shard1');
				case 2: Luxe.audio.play('border_shard2');
				case 3: Luxe.audio.play('border_shard3');
				case 4: Luxe.audio.play('border_shard4');
			}
		}
	}

	function hostDestroy() {
		var host: entity.Shard = cast entity;
		host.destroy();
	}


	override public function update(dt: Float) {
		entity.pos = new Vector( body.position.x, body.position.y);

		var host: luxe.Visual = cast entity;
		host.radians = this.body.rotation;
	}
}