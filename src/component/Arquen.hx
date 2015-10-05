package component;

import component.ArmBase;

import nape.geom.Vec2;
import nape.callbacks.InteractionCallback;

import PhysTypes;
import C;

class Arquen extends ArmBase {

	override function hitShard(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {

			// TODO extremely heavy impulse
			// TODO host.alive = false;
			// TODO Break constraint of everything
			// TODO Heavy bloodsplash
			// TODO Luxe.events.fire('Arque!');

		}
	}

}