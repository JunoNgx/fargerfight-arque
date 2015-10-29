package component;

import luxe.Vector;

import component.ArmBase;

import nape.geom.Vec2;
import nape.callbacks.InteractionCallback;

import PhysTypes;
import C;

class Armlet extends ArmBase {

	override function hitShard(callback: InteractionCallback) {

		if(callback.int1.castBody.id == body.id) {

			// Feedback for detachment of armlet from farger
			if (!this.detached) {
				Luxe.camera.shake(10);
				this.detached = true;
				body.cbTypes.remove( PhysTypes.armlet); // no longer an attached armlet, now just a normal and random body on the field

				// Enhance feedback by applying a force upon detachment
				// the armlet remain will fly around for a while
				// might (randomly) affect farger if direction is against it
				// var force = 700;
				var dir = Luxe.utils.random.float(Math.PI*2);
				body.applyImpulse(new Vec2(C.if_armlet * Math.cos(dir), C.if_armlet * Math.sin(dir)), body.position);
				body.angularVel = Luxe.utils.random.float(-1, 1);

				Luxe.events.fire('effect.spark', {pos: new Vector(body.position.x, body.position.y)});
				
				// Removal of constraint/joint
				var host: entity.PlayerBase = cast entity;
				if (this.name == 'armlet_lt') {
					host.joint_lt.active = false;
				}	
				if (this.name == 'armlet_rt') {
					host.joint_rt.active = false;
				}
			}

		}
	}

}