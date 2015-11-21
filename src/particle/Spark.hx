package particle;

import luxe.Color;
import luxe.Vector;

import particle.PartBase;
import C;

class Spark extends PartBase {
	
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

			speed: 40,
			end_speed: 10,
			speed_random: 0,

			start_color: new Color(1,1,1),
			end_color: new Color(1,1,1,1),

			start_size: new Vector(12, 12),
			start_size_random: new Vector(0,0),
			end_size: new Vector(0, 0),
			end_size_random: new Vector(0,0),
		});

		this.stop();
	}
}