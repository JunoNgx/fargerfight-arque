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
		host.physic.body.applyImpulse(new nape.geom.Vec2(e.xrel * 5.5, e.yrel * 5.5), host.physic.body.position);

		// Apply angular rotation force
		// var desRot = Math.atan2(e.yrel * 100, e.xrel * 100); // the direction of touch, or destination rotation
		var desRot = Math.atan2(host.physic.body.velocity.y, host.physic.body.velocity.x); // the direction of touch, or destination rotation
		var curRot = host.physic.body.rotation; // Current rotation of the body
		// Magical and clever code I don't quite understand. That is a very very bad habit.
		var diff = (desRot - curRot + Math.PI) % (2 * Math.PI) - Math.PI;

		host.physic.body.angularVel = diff * 2;
	}

	override public function onmouseup(e: MouseEvent) {
		isActive = false;

		var host: entity.PlayerBase = cast entity;
		host.physic.body.applyImpulse(new nape.geom.Vec2(0, 0), host.physic.body.position);

		// host.physic.body.angularVel = 1;
	}

	public function fire() {
		trace('left arm fired');
	}

	// override public function ontouchmove() {

	// }

	// override public function update(dt: Float) {

	// }

}