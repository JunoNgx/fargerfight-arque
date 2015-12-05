package particle;

import luxe.Color;
import luxe.Vector;

import particle.PartBase;

class Explosion extends PartBase {

		override public function new() {
		super({
			name: 'main',
			name_unique: true,
		});

		// variant 2: one big downsizing square at 45 deg
		this.add_emitter({

			depth: 2, // above fargers and even debug draw
			rotation: 45,

			emit_time: 0.01,
			emit_count: 1,

			life: 0.4,
			life_random: 0,

			pos_random: new Vector(0, 0),

			speed: 0,
			end_speed: 0,
			speed_random: 0,

			start_color: C.cShard,
			end_color: C.cShard,

			start_size: new Vector(64, 64),
			start_size_random: new Vector(0,0),
			end_size: new Vector(0, 0),
			end_size_random: new Vector(0,0),
		});


		// variant 1: multiple downsizing squares at 45 deg
		// this.add_emitter({

		// 	depth: 2, // above fargers and even debug draw
		// 	rotation: 45,

		// 	emit_time: 0.01,
		// 	emit_count: 7,

		// 	life: 0.3,
		// 	life_random: 0.2,

		// 	pos_random: new Vector(24, 24),

		// 	speed: 0,
		// 	end_speed: 0,
		// 	speed_random: 0,

		// 	start_color: new Color(1,1,1),
		// 	end_color: new Color(1,1,1,1),

		// 	start_size: new Vector(32, 32),
		// 	start_size_random: new Vector(0,0),
		// 	end_size: new Vector(0, 0),
		// 	end_size_random: new Vector(0,0),
		// });

		this.stop();
	}
}