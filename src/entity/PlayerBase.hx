package entity;

import luxe.Visual;
import luxe.Vector;
import luxe.Color;

import component.FargerPhysic;

import C;

class PlayerBase extends Visual {

	public var hp: Int = 3;

	public var physic: FargerPhysic;

	override public function init() {
		physic = new FargerPhysic();
		this.add(physic);
	}

}