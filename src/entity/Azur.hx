package entity;

import luxe.Vector;
import luxe.Color;

import C;

class Azur extends PlayerBase {

	override public function new() {
		super({
			name: 'azur',
		});
	}

	override public function init() {
		super.init();
		phys.body.position.setxy(Main.w * 0.25, Main.h * 0.5);

		this.add(new component.LeftTouchControl());

		// physic.body.angularVel = Math.PI;
	}
}