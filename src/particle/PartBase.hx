package particle;

import luxe.Color;
import luxe.Vector;
import luxe.Particles;

// Base class for particle systems in this game
class PartBase extends ParticleSystem {
	
	public function flash(_pos: Vector) {
		this.pos = _pos;
		this.start(0.01);
	}

}