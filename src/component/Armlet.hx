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

			var host: entity.PlayerBase = cast entity;
			if (this.name == 'armlet_lt') {
				entity.events.fire('detach.joint_lt');
			} else {
				entity.events.fire('detach.joint_rt');
			}

			Luxe.audio.play('hit_armlet');

			Luxe.events.fire('effect.spark', {pos: new Vector(this.body.position.x, this.body.position.y)});
		}
	}

}