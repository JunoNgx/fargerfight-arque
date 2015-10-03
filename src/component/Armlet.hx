package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

import nape.geom.Vec2;

// import nape.constraint.WeldJoint;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;

typedef ArmletOptions = {
	> ComponentOptions,
	var x: Float;
	var y: Float;
	var rot: Float;
}

class Armlet extends Component {

	public var body: Body;
	public var hitShardListener: InteractionListener;
	// public var constraint: WeldJoint;

	public var detached: Bool = false;
	
	override public function new (_options: ArmletOptions) {

		super(_options);

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add( new Polygon (Polygon.box( 64, 24)));
		body.setShapeMaterials(new Material(0.0, 0.0, 0.0));
		body.cbTypes.add( PhysTypes.armlet);
		body.space = Luxe.physics.nape.space;

		// Position and rotation from arguments
		body.position.setxy(Main.w * _options.x, Main.h * _options.y);
		body.rotation = _options.rot;

		// if (_options.upperpos) {
		// 	body.position.setxy(Main.w * 0.25, Main.h * 0.43);
		// } else {
		// 	body.position.setxy(Main.w * 0.25, Main.h * 0.57);
		// }

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		// Collision callbacks
		hitShardListener = new InteractionListener( CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.armlet,
			PhysTypes.shard,
			hitShard
		);
		Luxe.physics.nape.space.listeners.add(hitShardListener);

		// var host: entity.PlayerBase = cast entity;

		// // Constraint construction
		// constraint = new WeldJoint(
		// 	this.body,
		// 	host.phys.body,
		// 	new Vec2(0,0),
		// 	new Vec2(0,0),
		// 	0
		// );
	}

	function hitShard(callback: InteractionCallback) {

		if(callback.int1.castBody.id == body.id) {

			// Feedback for detachment of armlet from farger
			if (!this.detached) {
				Luxe.camera.shake(10);
				this.detached = true;
				body.cbTypes.remove( PhysTypes.armlet); // no longer an attached armlet, now just a normal and random body on the field

				// Enhance feedback by applying a force upon detachment
				// the armlet remain will fly around for a while
				// might (randomly) affect farger if direction is against it
				var force = 1000;
				var dir = Luxe.utils.random.float(Math.PI*2);
				body.applyImpulse(new nape.geom.Vec2(force * Math.cos(dir), force * Math.sin(dir)), body.position);
			}

			var host: entity.PlayerBase = cast entity;
			if (this.name == 'armlet_lt') {
				host.joint_lt.active = false;
			}	
			if (this.name == 'armlet_rt') {
				host.joint_rt.active = false;
			}
		}


		// if (states.Play.drawer != null) states.Play.drawer.remove(this.body);
		// Luxe.physics.nape.space.bodies.remove(this.body);
		// entity.remove(this.name);

		// trace(this.name);

		// var host: entity.PlayerBase = cast entity;

		// if (this.name == 'armlet_lt') {
		// 	host.joint_lt.active = false;
		// }

		// if (this.name == 'armlet_rt') {
		// 	host.joint_rt.active = false;
		// }
	}

	override public function init() {

	}

}