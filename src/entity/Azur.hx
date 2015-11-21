package entity;

import luxe.Vector;
import luxe.Color;

import nape.shape.Polygon;

import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import PhysTypes;
import C;

class Azur extends PlayerBase {
	
	override public function new() {
		super({
			name: 'azur',
			// debug only
			depth: -2
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
			y: 0.44,
			rot: -Math.PI/6,
		}));

		this.add(new component.Armlet({
			name: 'armlet_rt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.25,
			y: 0.56,
			rot: Math.PI/6,
		}));

		// Shield
		this.add(new component.Shield({
			name: 'shield',
			shape: C.body_shield,
			cbType: PhysTypes.shield,
			x: 0.28,
			y: 0.48,
			rot: 0,
		}));

		this.add(new component.Arquen({
			name: 'arquen',
			shape: C.body_arquen,
			cbType: PhysTypes.arquen,
			x: 0.28,
			y: 0.55,
			rot: 0,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Left());

		super.init(); // Assign properties and joinEquipments()
	}
}