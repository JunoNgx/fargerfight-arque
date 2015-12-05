package particle;

import luxe.Color;
import luxe.Vector;

import particle.PartBase;
import C;

class Essence extends PartBase { // read "blood", I'm just trying to be hipster
	
	override public function new() {
		super({
			name: 'main',
			name_unique: true,
		});

		this.add_emitter({

			depth: 2, // above fargers and even debug draw
			rotation: 45,
			direction_random: 360,
			life: 0.4,
			emit_time: 0.05,
			emit_count: 10,

			pos_random: new Vector(0, 0),

			speed: 50,
			end_speed: 20,
			speed_random: 0,

			start_color: new Color(1, 0.5, 0),
			end_color: new Color(1, 0.5, 0),

			start_size: new Vector(15, 15),
			start_size_random: new Vector(0,0),
			end_size: new Vector(0, 0),
			end_size_random: new Vector(0,0),
		});

		this.stop();
	}
}