package component;

import component.ArmBase;

import nape.geom.Vec2;
import nape.callbacks.InteractionCallback;

import PhysTypes;
import C;

class Shield extends ArmBase {

	override function hitShard(callback: InteractionCallback) {

		if(callback.int1.castBody.id == body.id) {
			// TODO spark without anything else
		}
	}

}