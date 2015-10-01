package entity;

import luxe.Visual;
import luxe.Vector;
import luxe.Color;

import component.FargerPhys;
import component.Armlet;
// import component.Shield;
// import component.Arquen;

import nape.phys.Body;
import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import C;

class PlayerBase extends Visual {

	public var hp: Int = 3;

	public var phys: FargerPhys;
	public var joint_rt: WeldJoint;
	public var joint_lt: WeldJoint;
	public var joint_sh: WeldJoint;
	public var joint_aq: WeldJoint;

	public var barrel: Vector;
	public var fire_cooldown: Float;

	override public function init() {
		this.radians = phys.body.rotation;
		this.barrel = new Vector();
		this.fire_cooldown = C.fire_cooldown;

		// Important lines that create joints/constraints for components
		acquireEquipments();
	}

	function acquireEquipments() {
		this.joint_lt = equipArmlet(this.get('armlet_lt'));
		this.joint_rt = equipArmlet(this.get('armlet_rt'));
	}

	function equipArmlet(_armlet: component.Armlet) {
		// var anchor = Vec2.weak (this.phys.body.position.x, Main.h * 0.5);
		var anchor = this.phys.body.position;
		var joint = new nape.constraint.WeldJoint(
			this.phys.body,
			_armlet.body,
			nape.geom.Vec2.weak(),
			_armlet.body.worldPointToLocal(anchor),
			0
		);
		joint.space = Luxe.physics.nape.space;

		// if (states.Play.drawer != null) joint.debugDraw = true;
		// no idea why the hell it doesn't work

		return joint;
		
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