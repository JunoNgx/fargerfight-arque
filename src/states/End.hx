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
	var arque: luxe.Text;
	var replay: luxe.Sprite;

	override public function onenabled <T> (_data:T) {

		result = new Text ({
			name: 't.result',
			name_unique: true, // to prevent this from being trapped in limbo with another of the same name, since many will be created in one session
			pos: new Vector(Main.w * 0.5, Main.h * 0.3),
			text: 'result',
			align: center,
			align_vertical: center,
			point_size: 96,
		});

		replay = new Sprite ({
			name: 'b.replay',
			name_unique: true,
			pos: new Vector (Main.w * 0.5, Main.h * 0.7),
			size: new Vector (128, 128),
		});

		var argsData: EndEvent = cast _data;
		// if (argsData.arque) {
		// 	result.text = 'Arque!';
		// } else if (argsData.draw) {
		// 	result.text = 'Draw';
		// } else if (argsData.azurwins) {
		// 	result.text = 'Azur wins';
		// } else {
		// 	result.text = 'Odeo wins';			
		// }

		if (argsData.azurwins) {
			result.text = 'azur wins';
		} else {
			result.text = 'odeo wins';
		}

		arque = new Text ({
			name: 't.arque',
			name_unique: true,
			pos: new Vector(Main.w * 0.5, Main.h * 0.5),
			text: 'arque!',
			align: center,
			align_vertical: center,
			point_size: 96,
			visible: argsData.arque, // important
		});

		Luxe.events.listen('end.draw', function (e) {
			result.text = 'draw';
		});

		// Luxe.events.listen('end.arque', function (e){
		// 	// result.text = 'arque!';
		// 	arque.visible = true;
		// });

	}

	override public function ondisabled <T> (_:T) {
		result.destroy();
		arque.destroy();
		replay.destroy();

		Luxe.events.unlisten('end.draw');
		Luxe.events.unlisten('end.arque');

		// Luxe.scene.empty();
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