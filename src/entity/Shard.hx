package entity;

import luxe.Sprite;
import luxe.Color;
import luxe.Vector;

import nape.geom.Vec2;

import component.ShardPhys;

import C;

class Shard extends Sprite {

	public var phys: ShardPhys;

	public var lifetime: Float = 0;
	public var owner: String;

	override public function new(_owner: String, _posX: Float, _posY: Float, _radians: Float) {

		super({
			name: 'shard',
			name_unique: true,
			// visible: false,
			depth: -3,
		});

		phys = new ShardPhys();
		this.add(phys);

		owner = _owner;
		phys.body.position.setxy(_posX, _posY);
		phys.body.rotation = _radians;
		this.radians = phys.body.rotation;

		this.phys.body.applyImpulse(new Vec2( 
			C.shard_speed * Math.cos(this.radians),
			C.shard_speed * Math.sin(this.radians)
		));
	}

	override public function init() {

	}

	override public function update(dt: Float) {

		if (lifetime < C.shard_lifetime) {
			lifetime += dt;
		} else {
			destroy();
			Luxe.events.fire('effect.explosion', {pos: this.pos});
		} 
	}

	override public function ondestroy() {
		if (states.Play.drawer != null) states.Play.drawer.remove(this.phys.body);
		Luxe.physics.nape.space.bodies.remove(this.phys.body);
		super.ondestroy();
	}
}