package entity;

import luxe.Visual;
import luxe.Vector;
import luxe.Color;

// import component.FargerPhys;
// import component.Armlet;
// import component.Shield;
// import component.Arquen;

import nape.phys.Body;
import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import C;

class PlayerBase extends Visual {

	public var hp: Int = 3;
	public var alive: Bool = true;

	public var phys: component.FargerPhys;
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
		joinEquipments(); // Equip all armpieces using joinEquipments()
	}

	function joinEquipments() {
		this.joint_lt = equipArmor(this.get('armlet_lt'));
		this.joint_rt = equipArmor(this.get('armlet_rt'));
		this.joint_sh = equipArmor(this.get('shield'));
		this.joint_aq = equipArmor(this.get('arquen'));
	}

	// Create a joint/constraint with a component.ArmBase
	// (all of whom Farger's components are based on)
	function equipArmor(_armpiece: component.ArmBase) {
		var anchor = this.phys.body.position;
		var joint = new nape.constraint.WeldJoint(
			this.phys.body,
			_armpiece.body,
			nape.geom.Vec2.weak(),
			_armpiece.body.worldPointToLocal(anchor),
			0
		);
		joint.space = Luxe.physics.nape.space;
		return joint;
	}

	// function equipArmlet(_armlet: component.Armlet) {
	// 	// var anchor = Vec2.weak (this.phys.body.position.x, Main.h * 0.5);
	// 	var anchor = this.phys.body.position;
	// 	var joint = new nape.constraint.WeldJoint(
	// 		this.phys.body,
	// 		_armlet.body,
	// 		nape.geom.Vec2.weak(),
	// 		_armlet.body.worldPointToLocal(anchor),
	// 		0
	// 	);
	// 	joint.space = Luxe.physics.nape.space;

	// 	// if (states.Play.drawer != null) joint.debugDraw = true;
	// 	// no idea why the hell it doesn't work

	// 	return joint;
		
	// }

	override public function update(dt: Float) {
		
		barrel.x = this.pos.x + C.barrel_length * Math.cos(this.radians + Math.PI * 11/28);
		barrel.y = this.pos.y + C.barrel_length * Math.sin(this.radians + Math.PI * 11/28);

		if (this.fire_cooldown < C.fire_cooldown) this.fire_cooldown += dt;

		// DebugArea
		Luxe.draw.text({
			text: '${hp}',
			pos: new Vector(this.pos.x, this.pos.y - 64),
			point_size: 48,
			align: right,
			immediate: true,
			depth: 20,
			color: new Color().rgb(0xdddddd),
		});
		
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