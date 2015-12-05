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

			Luxe.timescale = 0.001; // Simulate the termporarily paused game effect by setting Luxe.timescale to a near zero
			trace('timescale semi-frozen'); 

			Luxe.timer.schedule(0.5, function(){ // Restore timescale in 0.5 seconds
				Luxe.timescale = 1;
				trace('timescale restored');

				// Splash essence base the other body ```callback.int2``` and ```angle``` being calculated above
				Luxe.events.fire('effect.essence.splash', {pos: new Vector(this.body.position.x, this.body.position.y), direction: -angle});
				Luxe.events.fire('effect.essence', {pos: new Vector(this.body.position.x, this.body.position.y)});
				host.bleed(1.2);
			});
		}
	}

	override public function update(dt: Float) {
		var host: luxe.Visual = cast entity;

		host.pos = new Vector( body.position.x, body.position.y);
		host.radians = body.rotation;

		super.update(dt); // to update its gfx inherited from ArmBase
	}

	public function shaken() {
	// apply an impulse to main body for enhanced feedback
	// called when farger dies
		var angle: Float = Luxe.utils.random.float(-Math.PI * 2, Math.PI * 2);
		var force: Float = 4000;

		body.applyImpulse(new Vec2(force * Math.cos(angle), force * Math.sin(angle)), body.position);
	}
}