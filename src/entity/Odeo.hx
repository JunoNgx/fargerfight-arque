package entity;

import luxe.Vector;
import luxe.Color;

import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import C;

class Odeo extends PlayerBase {
	
	override public function new(_c: Color) {
		super({
			name: 'odeo',
			depth: -2,
			texture: Luxe.resources.texture('assets/farger_entity.png'),
			color: _c,
		});

		phys = new component.FargerPhys({
			name: 'physic',
			shape: C.body_farger,
			cbType: PhysTypes.farger,
			x: 0.75, y: 0.5, rot: -Math.PI,
			texture: Luxe.resources.texture('assets/farger_phys.png'),
			color: C.cShard,
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
			y: 0.56,
			rot: -Math.PI - Math.PI/6,
			texture: Luxe.resources.texture('assets/armlet_lt.png'),
			color: C.cShard,
		}));

		this.add(new component.Armlet({
			name: 'armlet_rt',
			shape: C.body_armlet,
			cbType: PhysTypes.armlet,
			x: 0.75,
			y: 0.44,
			rot: -Math.PI + Math.PI/6,
			texture: Luxe.resources.texture('assets/armlet_rt.png'),
			color: C.cShard,
		}));

		// Shield
		this.add(new component.Shield({
			name: 'shield',
			shape: C.body_shield,
			cbType: PhysTypes.shield,
			x: 0.72,
			y: 0.52,
			rot: -Math.PI,
			texture: Luxe.resources.texture('assets/shield.png'),
			color: C.cShard,
		}));

		this.add(new component.Arquen({
			name: 'arquen',
			shape: C.body_arquen,
			cbType: PhysTypes.arquen,
			x: 0.72,
			y: 0.45,
			rot: -Math.PI,
			texture: Luxe.resources.texture('assets/arquen.png'),
			color: C.cShard,
		}));

		// entity-specific controller
		this.add(new component.touchcontrol.Right());
		
		// hp indicator
		this.add(new component.Indicator({name: 'indicator'}));

		super.init();
	}
}