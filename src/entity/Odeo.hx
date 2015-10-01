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

class Odeo extends PlayerBase {
	
	override public function new() {
		super({
			name: 'odeo',
		});

		phys = new FargerPhys(0.75, 0.5, -Math.PI); // x and y relative coordinates, rotation
		this.add(phys);
	}

	override public function init() {

		this.add(new Armlet({
			name: 'armlet_lt',
			x: 0.75,
			y: 0.57,
			rot: -Math.PI,
		}));

		this.add(new Armlet({
			name: 'armlet_rt',
			x: 0.75,
			y: 0.43,
			rot: -Math.PI,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Right());

		super.init();
	}
}