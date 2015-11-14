package states;

import luxe.States;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Camera;
import luxe.Input;

import luxe.Text;

import C;

class End extends State {
	
	var result: luxe.Text;
	var replay: luxe.Sprite;

	public function onenable <T> (_data:T) {

		result = new Text ({
			name: 't.result',
			pos: new Vector(Main.w * 0.5, Main.h * 0.5),
			align: center,
			point_size: 96,
		});

		replay = new Sprite ({
			name: 'b.replay',
			pos: new Vector (Main.w * 0.5, Main.h * 0.75),
			size: new Vector (128, 128),
		});


		var argsData: EndEvent = cast _data;
		if (argsData.arque) {
			result.text = 'Arque!';
		} else if (argsData.draw) {
			result.text = 'Draw';
		} else if (argsData.azurwins) {
			result.text = 'Azur wins';
		} else {
			result.text = 'Odeo wins';			
		}

	}

	public function ondisable <T> (_:T) {
		result.destroy();
		replay.destroy();
	}

	override function onmousedown(e: MouseEvent) {
		if (replay.point_inside(Luxe.camera.screen_point_to_world(e.pos))) {
			Main.state.disable('end');
			Main.state.set('play');
		}
	}

}

typedef EndEvent = {
	arque: Bool,
	draw: Bool,
	azurwins: Bool
}