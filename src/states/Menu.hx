package states;

import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Color;
import luxe.Vector;
import luxe.Camera;

import luxe.Text;

import C;

class Menu extends State {

	// var title: Text;
	var title: Sprite;
	var playButton: Sprite;
	var instruction: Text;
	var copyright: Text;

	var luxe: Sprite;
	var aureotetra: Sprite;

	override public function onenabled <T> (_:T) {
		// title = new Text({
		// 	name: 't.title',
		// 	name_unique: true,
		// 	text: 'Fargerfight Arque',
		// 	pos: new Vector(Main.w * 0.5, Main.h * 0.1),
		// 	point_size: 128,
		// 	align: center,
		// });

		title = new Sprite({
			name: 't.title',
			// name_unique: true,
			pos: new Vector(Main.w * 0.5, Main.h * 0.2),
			texture: Luxe.resources.texture('assets/arque_title.png'),
		});

		playButton = new Sprite ({
			name: 'b.play',
			// name_unique: true,
			size: new Vector (128, 128),
			pos: new Vector (Main.w * 0.5, Main.h * 0.5),
			texture: Luxe.resources.texture('assets/button_play.png'),
		});

		instruction = new Text({
			name: 't.instruction',
			// name_unique: true,
			text: 'on each half of the screen \n touch and move to maneuvre // double tap to attack',
			pos: new Vector(Main.w * 0.5, Main.h * 0.7),
			point_size: 32,
			align: center,
			font: Main.raleway32,
			color: C.cText,
		});

		copyright = new Text({
			name: 't.copyright',
			name_unique: true,
			text: '2016 Aureoline Tetrahedron',
			pos: new Vector(Main.w * 0.5, Main.h * 0.9),
			// point_size: 128,
			align: center,
			font: Main.raleway32,
			color: C.cText,
		});

		luxe = new Sprite({
			name: 'luxelogo',
			name_unique: true,
			size: new Vector(96, 96),
			pos: new Vector(Main.w * 0.94, Main.h * 0.9),
			texture: Luxe.resources.texture('assets/logo_luxe.png'),
		});

		aureotetra = new Sprite({
			name: 'aureotetralogo',
			name_unique: true,
			size: new Vector(64, 64),
			pos: new Vector(Main.w * 0.69, Main.h * 0.91),
			texture: Luxe.resources.texture('assets/logo_aureotetra.png'),
		});
	}

	override public function ondisabled <T> (_:T) {
		title.destroy();
		playButton.destroy();
		instruction.destroy();
		copyright.destroy();

		luxe.destroy();
		aureotetra.destroy();
	}

	override function onmousedown(e: MouseEvent) {
		if (playButton.point_inside(Luxe.camera.screen_point_to_world(e.pos))) {
			Main.state.disable('menu');
		}
	}

}