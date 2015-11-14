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
	
	public static var result: luxe.Text;

	public function onenable <T> (_data:T) {
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

	}

}

typedef EndEvent = {
	arque: Bool,
	draw: Bool,
	azurwins: Bool
}