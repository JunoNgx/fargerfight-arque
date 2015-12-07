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
			trace('arque!');

			Luxe.audio.play('arque_impact');
			Luxe.camera.shake(80);
		}
	}

}