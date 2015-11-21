package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import C;

// Component that drips blood nearby when farger is hit
// to simulate bleeding visually
class Bloodbag extends Component {

	public var bleeding_time: Float = 0;

	override public function new() {
		super({
			name: 'bloodbag'
		});
	}

	override public function update(dt: Float) {

		// If bleeding timeout is not due yet,
		// continuously and randomly drips essence
		if (bleeding_time > 0) {
			bleeding_time -= dt;
			if (Luxe.utils.random.sign(0.3) == 1) Luxe.events.fire('effect.essence.drip', {pos: entity.pos}); // performed by states.Play.hx
		}
	}

}