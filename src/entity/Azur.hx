package entity;

import luxe.Vector;
import luxe.Color;

// import component.FargerPhys;
// import component.Armlet;
// import component.Shield;
// import component.Arquen;

import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import PhysTypes;
import C;

class Azur extends PlayerBase {
	
	override public function new() {
		super({
			name: 'azur',
		});

		phys = new component.FargerPhys({
			name: 'physic',
			shape: C.body_farger,
			cbType: PhysTypes.farger,
			x: 0.25, y: 0.5, rot: 0  // x and y relative coordinates, rotation
		});
		this.add(phys);
	}

	override public function init() {

		this.add(new component.Armlet({
			name: 'armlet_lt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.25,
			y: 0.43,
			rot: 0,
		}));

		this.add(new component.Armlet({
			name: 'armlet_rt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.25,
			y: 0.57,
			rot: 0,
		}));

		// Shield
		this.add(new component.Shield({
			name: 'shield',
			shape: C.body_shield,
			cbType: PhysTypes.shield,
			x: 0.3,
			y: 0.48,
			rot: 0,
		}));

		this.add(new component.Arquen({
			name: 'arquen',
			shape: C.body_arquen,
			cbType: PhysTypes.arquen,
			x: 0.3,
			y: 0.54,
			rot: 0,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Left());

		super.init(); // Assign properties and joinEquipments()
	}
}