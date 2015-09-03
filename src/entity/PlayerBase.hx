package entity;

import luxe.Visual;
import luxe.Vector;
import luxe.Color;

import component.FargerPhys;

import C;

class PlayerBase extends Visual {

	public var hp: Int = 3;

	public var phys: FargerPhys;

	public var barrel: Vector;

	override public function init() {
		phys = new FargerPhys();
		this.add(phys);

		this.radians = phys.body.rotation;

		this.barrel = new Vector();
	}

	override public function update(dt: Float) {
		
		barrel.x = this.pos.x + 54 * Math.cos(this.radians + Math.PI * 11/28);
		barrel.y = this.pos.y + 54 * Math.sin(this.radians + Math.PI * 11/28);
		
	}

	public function fire() {
		trace('arm fired');

		var shard = new entity.Shard('azur', this.barrel.x, this.barrel.y, this.radians);
	}

}