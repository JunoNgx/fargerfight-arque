package particle;

import luxe.Color;
import luxe.Vector;

import luxe.Particles;
import luxe.ParticleSystem;

class Essence extends ParticleSystem { // read "blood", I'm just trying to be hipster
	
	override public function new() {
		super({
			name: 'main',
			name_unique: true,
		});

		this.add_emitter({
			depth: -2, // on the ground, below fargers and everything else
		});
	}

}

// class Muzzleflash extends ParticleSystem {

// 	override public function new() {
// 		super({
// 			name: 'muzzleflash',
// 		});

// 		this.add_emitter({
// 			name: 'main',

// 			depth: 2,
// 			rotation: 45,
// 			direction_random: 45,
// 			life: 0.4,
// 			emit_time: 0.1,
// 			emit_count: 5,

// 			start_size: new Vector( 24, 24),
// 			start_size_random: new Vector(0, 0),
// 			start_color: Main.c2.clone(),
// 			speed: 20,
// 			speed_random: 5,

// 			end_size: new Vector(1, 1),
// 			// end_size_random: new Vector(0, 0),
// 			end_color: Main.c2.clone(),
// 			end_speed: 10,
// 		});

// 		this.stop( );
// 	}

// 	public function flash(_pos: Vector, _direction: Float) {
// 		this.emitters.get('main').direction = _direction;
// 		this.pos = _pos;
// 		this.start(0.1);
// 	}
// }