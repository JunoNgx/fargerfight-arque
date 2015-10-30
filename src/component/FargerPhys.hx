package component;

import component.ArmBase;

import luxe.Vector;

import nape.geom.Vec2;
import nape.callbacks.InteractionCallback;

import PhysTypes;
import C;

class FargerPhys extends ArmBase {

	override function hitShard(callback: InteractionCallback) {
	
		if(callback.int1.castBody.id == body.id) {
			var host: entity.PlayerBase = cast entity;
			host.hp -= 1;

			trace('lost 1 hp');

			// Push the fighter away when hit for enhanced feedback
			var angle: Float = Math.atan2(
				callback.int1.castBody.position.y - callback.int2.castBody.position.y,
				callback.int1.castBody.position.x - callback.int2.castBody.position.x
			);
			var force:Float = 2000;
			body.applyImpulse(new Vec2(force * Math.cos(angle), force * Math.sin(angle)), body.position);

			// BUG: very random direction of force
			// TODO if (hp == 1) force = 5000;

			// Splash essence base the other body ```callback.int2```
			Luxe.events.fire('effect.essence.splash', {pos: new Vector(this.body.position.x, this.body.position.y), direction: -callback.int2.castBody.rotation});
			host.bleed(1.2);
		}

		// TODO Slowmo
	}

	override public function update(dt: Float) {
		var host: luxe.Visual = cast entity;

		host.pos = new Vector( body.position.x, body.position.y);
		host.radians = body.rotation;
	}
}