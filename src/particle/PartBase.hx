package particle;

import luxe.Color;
import luxe.Vector;
import luxe.Particles;

// Base class for particle systems in this game
// this would make extension to all particle systems easier if needed
class PartBase extends ParticleSystem {
	
	public function flash(_pos: Vector, ?_direction: Float) {
		this.pos = _pos;
		if (_direction != null) this.emitters.get('main').direction = _direction;

		this.start(0.01);
	}

}