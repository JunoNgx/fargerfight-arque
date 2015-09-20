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
	public var fire_cooldown: Float;

	override public function init() {
		phys = new FargerPhys();
		this.add(phys);

		this.radians = phys.body.rotation;
		this.barrel = new Vector();
		this.fire_cooldown = C.fire_cooldown;
	}

	override public function update(dt: Float) {
		
		barrel.x = this.pos.x + C.barrel_length * Math.cos(this.radians + Math.PI * 11/28);
		barrel.y = this.pos.y + C.barrel_length * Math.sin(this.radians + Math.PI * 11/28);

		if (this.fire_cooldown < C.fire_cooldown) this.fire_cooldown += dt;
		
	}

	public function fire() {
		trace('arm fired');

		// Check if already cooldowned and ready to fire
		if (this.fire_cooldown >= C.fire_cooldown) {
			var shard = new entity.Shard('azur', this.barrel.x, this.barrel.y, this.radians);
			this.fire_cooldown = 0;
		} else {
			// Luxe.audio.play('notreadytofire');
		}
		
	}

}