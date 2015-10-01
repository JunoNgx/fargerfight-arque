package entity;

import luxe.Visual;
import luxe.Vector;
import luxe.Color;

import component.FargerPhys;
import component.Armlet;

import nape.geom.Vec2;
import nape.constraint.WeldJoint;

import C;

class PlayerBase extends Visual {

	public var hp: Int = 3;

	public var phys: FargerPhys;

	public var barrel: Vector;
	public var fire_cooldown: Float;

	override public function init() {
		phys = new FargerPhys();
		this.add(phys);

		// rotateMainBody();

		this.radians = phys.body.rotation;
		this.barrel = new Vector();
		this.fire_cooldown = C.fire_cooldown;

		equipArmletLt();
		equipArmletRt();
		equipShield();
		equipArquen();
	}

	function equipArmletLt() {
		this.add(new Armlet({
			name: 'armlet_lt',
			upperpos: true,
			leftside: true,
		}));

		var anchor = nape.geom.Vec2.weak (Main.w * 0.25, Main.h * 0.5);
		var joint = new nape.constraint.WeldJoint(
			this.phys.body,
			this.get('armlet_lt').body,
			nape.geom.Vec2.weak(),
			this.get('armlet_lt').body.worldPointToLocal(anchor),
			0
		);
		joint.space = Luxe.physics.nape.space;

		// // I have no idea why this works, but it works
		// var anchor = nape.geom.Vec2.weak (Main.w * 0.25, Main.h * 0.5);
		// var joint = new nape.constraint.WeldJoint(
		// 	this.phys.body,
		// 	this.get('armlet').body,
		// 	nape.geom.Vec2.weak(),
		// 	this.get('armlet').body.worldPointToLocal(anchor),
		// 	0
		// );
		// joint.space = Luxe.physics.nape.space;


		// var constraint = new nape.constraint.WeldJoint(this.phys.body, this.get('armlet').body,
		// 	this.phys.body.worldPointToLocal(weldPoint, true),
		// 	this.get('armlet').body.worldPointToLocal(weldPoint, true),
		// 	0);

		// // For archiving purposes
		// var constraint = new nape.constraint.WeldJoint(this.phys.body, this.get('armlet').body,
		// 	// new nape.geom.Vec2(0, 0), new nape.geom.Vec2( 0, 0), Math.PI/2);
		// 	// this.phys.body.worldPointToLocal(weldPoint, true),
		// 	this.get('armlet').body.worldPointToLocal(weldPoint, true),
		// 	nape.geom.Vec2.weak(),
		// 	0);
			// this.phys.body., new nape.geom.Vec2( 0,0), 0 );

		// // One method that works
		// var constraint = new nape.constraint.WeldJoint(this.phys.body, this.get('armlet').body,
		// 	nape.geom.Vec2.weak(),
		// 	this.get('armlet').body.worldPointToLocal(anchor, true),
		// 	0);

		// constraint.space = Luxe.physics.nape.space;
	}

	function equipArmletRt() {
		this.add(new Armlet({
			name: 'armlet_rt',
			upperpos: false,
			leftside: true,
		}));

		var anchor = nape.geom.Vec2.weak (Main.w * 0.25, Main.h * 0.5);
		var joint = new WeldJoint(
			this.phys.body,
			this.get('armlet_rt').body,
			Vec2.weak(),
			this.get('armlet_rt').body.worldPointToLocal(anchor),
			0
		);
		joint.space = Luxe.physics.nape.space;
	}

	function equipArquen() {
		
	}

	function equipShield() {

	}

	function rotateMainBody() {
		this.phys.body.rotation = 0;
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