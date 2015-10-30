package prop;

import luxe.Sprite;
import luxe.Color;
import luxe.Vector;

class Essence extends Sprite { // Read: blood. I'm just trying to be absurdly pretentious

	override public function new(_pos: Vector, _scale: Vector) {
		super({
			name: 'essence',
			name_unique: true,
			depth: -5, // above the background, but below fargers and other objects
			size: new Vector(32, 32),

			color: new Color(1, 0.5, 0),
			rotation_z: 45,

			pos: _pos,
			scale: _scale,
		});

	}

}