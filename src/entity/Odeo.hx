package entity;

import luxe.Vector;
import luxe.Color;

// import component.FargerPhys;
// import component.Armlet;
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

		phys = new component.FargerPhys({
			name: 'physic',
			shape: C.body_farger,
			cbType: PhysTypes.armlet,
			x: 0.75, y: 0.5, rot: -Math.PI
		});
		this.add(phys);
	}

	override public function init() {

		// Two armlets on each side
		this.add(new component.Armlet({
			name: 'armlet_lt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.75,
			y: 0.57,
			rot: -Math.PI,
		}));

		this.add(new component.Armlet({
			name: 'armlet_rt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.75,
			y: 0.43,
			rot: -Math.PI,
		}));

		// Shield
		this.add(new component.Shield({
			name: 'shield',
			shape: C.body_shield,
			cbType: PhysTypes.shield,
			x: 0.7,
			y: 0.52,
			rot: -Math.PI
		}));

		this.add(new component.Arquen({
			name: 'arquen',
			shape: C.body_arquen,
			cbType: PhysTypes.arquen,
			x: 0.7,
			y: 0.46,
			rot: -Math.PI,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Right());

		super.init();
	}
}