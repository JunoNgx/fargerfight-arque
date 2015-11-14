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

	var title: Text;
	var playButton: Sprite;
	var instruction: Text;
	var copyright: Text;

	override public function onenabled <T> (_:T) {
		title = new Text({
			name: 't.title',
			text: 'Fargerfight Arque',
			pos: new Vector(Main.w * 0.5, Main.h * 0.1),
			point_size: 128,
			align: center
		});

		playButton = new Sprite ({
			name: 'b.play',
			size: new Vector (128, 128),
			pos: new Vector (Main.w * 0.5, Main.h * 0.5),
		});

		instruction = new Text({
			name: 't.instruction',
			text: 'on each half of the screen \n swipe to move // double tap to fire',
			pos: new Vector(Main.w * 0.5, Main.h * 0.7),
			// point_size: 128,
			align: center
		});

		copyright = new Text({
			name: 't.copyright',
			text: '2016 Aureoline Tetrahedron',
			pos: new Vector(Main.w * 0.5, Main.h * 0.9),
			// point_size: 128,
			align: center
		});
	}

	override public function ondisabled <T> (_:T) {
		title.destroy();
		playButton.destroy();
		instruction.destroy();
		copyright.destroy();
	}

	override function onmousedown(e: MouseEvent) {
		if (playButton.point_inside(Luxe.camera.screen_point_to_world(e.pos))) {
			Main.state.disable('menu');
		}
	}

}