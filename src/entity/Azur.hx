package entity;

import luxe.Vector;
import luxe.Color;

import component.FargerPhys;
import component.Armlet;
// import component.Shield;
// import component.Arquen;

import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import C;

class Azur extends PlayerBase {
	
	override public function new() {
		super({
			name: 'azur',
		});

		phys = new FargerPhys(0.25, 0.5, 0); // x and y relative coordinates, rotation
		this.add(phys);
	}

	override public function init() {

		this.add(new Armlet({
			name: 'armlet_lt',
			x: 0.25,
			y: 0.43,
			rot: 0,
		}));

		this.add(new Armlet({
			name: 'armlet_rt',
			x: 0.25,
			y: 0.57,
			rot: 0,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Left());

		super.init();
	}
}