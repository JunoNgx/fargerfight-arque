package entity;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

// import component.FargerPhys;
// import component.Armlet;
// import component.Shield;
// import component.Arquen;

import nape.phys.Body;
import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import PhysTypes;
import C;

class PlayerBase extends Sprite {

	public var hp: Int = 1;
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

		this.add(new component.Bloodbag());

		// Important lines that create joints/constraints for components
		joinEquipments(); // Equip all armpieces using joinEquipments()
		setupEvents(); // Start listening to events which will detach joints when needed
	}

	function joinEquipments() {
		this.joint_lt = equipArmor(this.get('armlet_lt'), -Math.PI/6);
		this.joint_rt = equipArmor(this.get('armlet_rt'), Math.PI/6);
		this.joint_sh = equipArmor(this.get('shield'), 0);
		this.joint_aq = equipArmor(this.get('arquen'), 0);
	}

	function setupEvents() {
		this.events.listen('detach.joint_lt', detach_left);
		this.events.listen('detach.joint_rt', detach_right);

		this.events.listen('die', function(_e: DetachEvent) { // this event is similar to the hit event in component.FargerPhys

			Luxe.timescale = 0.001; // Simulate the termporarily paused game effect by setting Luxe.timescale to a near zero
			trace('timescale semi-frozen'); 

			this.alive = false;
			this.hp = 0;

			// farger can no longer be controlled
			this.remove('controller');

			Luxe.timer.schedule(0.8, function(){ // Restore timescale in 0.8 seconds
				Luxe.timescale = 1;
				// Luxe.camera.shake(50);
				
				// Remove all joints (and disable all cbTypes as well)
				this.events.fire('detach.joint_lt');
				this.events.fire('detach.joint_rt');
				this.detach(this.get('shield'));
				this.detach(this.get('arquen'));

				// remove collision detection for main body
				var farger: component.FargerPhys = cast this.get('physic');
				farger.body.cbTypes.remove(PhysTypes.farger);
				// move the main body for enhanced feedback
				farger.shaken();

				// blood splash is handled by component.Arquen;

				// send signal to game engine to determine who dies and who wins
				Luxe.events.fire(this.name + '.died');
				trace(this.name + '.died');
			});
		});
	}

	function detach_left(_e: DetachEvent) {
		var armlet: component.Armlet = this.get('armlet_lt');

		if (!armlet.detached) {
			Luxe.camera.shake(10);
			armlet.detached = true;
			armlet.body.cbTypes.remove( PhysTypes.armlet); // no longer an attached armlet, now just a normal and random body on the field

			// Enhance feedback by applying a force upon detachment
			// the armlet remain will fly around for a while
			// might (randomly) affect farger if direction is against it
			var dir = Luxe.utils.random.float(Math.PI*2);
			armlet.body.applyImpulse(new Vec2(C.if_armlet * Math.cos(dir), C.if_armlet * Math.sin(dir)), armlet.body.position);
			armlet.body.angularVel = Luxe.utils.random.float(-Math.PI * C.if_angular_multiplier, Math.PI * C.if_angular_multiplier);
			// Removal of constraint/joint
			this.joint_lt.active = false;
		}
	}

	function detach_right(_e: DetachEvent) {
		var armlet: component.Armlet = this.get('armlet_rt');

		if (!armlet.detached) {
			Luxe.camera.shake(10);
			armlet.detached = true;
			armlet.body.cbTypes.remove( PhysTypes.armlet); // no longer an attached armlet, now just a normal and random body on the field

			// Enhance feedback by applying a force upon detachment
			// the armlet remain will fly around for a while
			// might (randomly) affect farger if direction is against it
			var dir = Luxe.utils.random.float(Math.PI*2);
			armlet.body.applyImpulse(new Vec2(C.if_armlet * Math.cos(dir), C.if_armlet * Math.sin(dir)), armlet.body.position);
			armlet.body.angularVel = Luxe.utils.random.float(-Math.PI * C.if_angular_multiplier, Math.PI * C.if_angular_multiplier);

			// Removal of constraint/joint
			this.joint_rt.active = false;
		}	
	}

	// This is just used to detach arquen and shield upon farger's death
	function detach(_arm: component.ArmBase) {
		_arm.detached = true;

		var dir = Luxe.utils.random.float(Math.PI*2);
		_arm.body.applyImpulse(new Vec2(C.if_armbase * Math.cos(dir), C.if_armlet * Math.sin(dir)), _arm.body.position);
		_arm.body.angularVel = Luxe.utils.random.float(-Math.PI * C.if_angular_multiplier, Math.PI * C.if_angular_multiplier);

		if (_arm.name == 'shield') {
			_arm.body.cbTypes.remove( PhysTypes.shield); 
			this.joint_sh.active = false;
		} else {
			_arm.body.cbTypes.remove( PhysTypes.arquen);
			this.joint_aq.active = false;
		}
	}	

	// Create a joint/constraint with a component.ArmBase
	// (all of whom Farger's components are based on)
	function equipArmor(_armpiece: component.ArmBase, _phase: Float) {
		var anchor = this.phys.body.position;
		var joint = new nape.constraint.WeldJoint(
			this.phys.body,
			_armpiece.body,
			nape.geom.Vec2.weak(),
			_armpiece.body.worldPointToLocal(anchor),
			_phase // offset of rotation between two bodies
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
		
		barrel.x = this.pos.x + C.barrel_length * Math.cos(this.radians + Math.PI * C.barrel_angle);
		barrel.y = this.pos.y + C.barrel_length * Math.sin(this.radians + Math.PI * C.barrel_angle);

		if (this.fire_cooldown < C.fire_cooldown) this.fire_cooldown += dt;

		if (this.alive && this.hp == 0) {
			this.events.fire('die');		
			Luxe.camera.shake(50);
		}


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

		Luxe.draw.ngon({
			pos: this.barrel,
			r: 3,
			sides: 4,
			immediate: true,
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

	public function bleed(_time: Float) {
		this.get('bloodbag').bleeding_time = _time;
	}

}

typedef DetachEvent = {
	direction: Float
}