package particle;

import luxe.Color;
import luxe.Vector;

import luxe.Particles;
import luxe.ParticleSystem;

class Spark extends ParticleSystem {
	
	override public function new() {
		super({
			name: 'part.spark',
			name_unique: true,
		})

		this.add_emitter({


			depth: 2, // above fargers and even debug draw
			direction_random: 360,

			// speed: 
			// speed_random: ,
		});
	}

}