package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Color;
import luxe.Vector;
import luxe.Input;

class BaseTouchControl extends Component {

	public var isActive: Bool = false;
	public var lastPress: Float;

	override public function new () {
		super({
			name: 'controller'
		});
	}

	override public function onmousedown(e: MouseEvent) {
		// if (e.x < Main.w/2) isActive = true;

		isActive = true;
		if ((Luxe.time - lastPress) < 0.3) fire();
		lastPress = Luxe.time;
	}

	override public function onmousemove(e: MouseEvent) {
		if (!isActive) return;

		// Apply linear force to object
		var host: entity.PlayerBase = cast entity;
		host.phys.body.applyImpulse(new nape.geom.Vec2(e.xrel * C.force_multiplier, e.yrel * C.force_multiplier), host.phys.body.position);

		// Apply angular rotation force
		// var desRot = Math.atan2(e.yrel * 100, e.xrel * 100); // the direction of touch, or destination rotation
		var desRot = Math.atan2(host.phys.body.velocity.y, host.phys.body.velocity.x); // the direction of touch, or destination rotation
		var curRot = host.phys.body.rotation; // Current rotation of the body
		// Magical and clever code I don't quite understand. That is a very very bad habit.
		var diff = (desRot - curRot + Math.PI) % (2 * Math.PI) - Math.PI;

		host.phys.body.angularVel = diff * 2;
	}

	override public function onmouseup(e: MouseEvent) {
		isActive = false;

		var host: entity.PlayerBase = cast entity;
		host.phys.body.applyImpulse(new nape.geom.Vec2(0, 0), host.phys.body.position);

		// host.phys.body.angularVel = 1;
	}

	public function fire() {
		var host: entity.PlayerBase = cast entity;

		host.fire();
	}

	// override public function ontouchmove() {

	// }

	// override public function update(dt: Float) {

	// }

}