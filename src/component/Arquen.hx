package component;

import component.ArmBase;

import luxe.Vector;

import nape.geom.Vec2;
import nape.callbacks.InteractionCallback;

import PhysTypes;
import C;

class Arquen extends ArmBase {

	override function hitShard(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {
			var host: entity.PlayerBase = cast entity;

			host.events.fire('die');
			host.bleed(1.2);
			
			Luxe.events.fire('effect.essence', {pos: new Vector(this.body.position.x, this.body.position.y)});
			Luxe.events.fire('effect.essence.splash.heavy', {pos: new Vector(this.body.position.x, this.body.position.y)});

			Luxe.events.fire('arque!');

			Luxe.camera.shake(80);

			// Done in PlayerBase - TODO extremely heavy impulse
			// Done in PlayerBase - TODO host.alive = false;
			// Done in PlayerBase - TODO Break constraint of everything
			// Done - TODO Heavy bloodsplash
			// Done - TODO Luxe.events.fire('Arque!');

		}
	}

}