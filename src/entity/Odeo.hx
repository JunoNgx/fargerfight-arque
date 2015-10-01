package entity;

import luxe.Vector;
import luxe.Color;

import C;

class Odeo extends PlayerBase {
	
	override public function new() {
		super({
			name: 'odeo',
		});
	}

	override public function init() {
		super.init();
		phys.body.position.setxy(Main.w * 0.75, Main.h * 0.5);

		this.add(new component.RightTouchControl());

		// physic.body.angularVel = Math.PI;
	}
}