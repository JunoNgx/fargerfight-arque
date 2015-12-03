package;

import luxe.Screen.WindowEvent;
import luxe.Vector;
import luxe.Color;
import luxe.Camera;

import luxe.States;

class Main extends luxe.Game {

	var initialState: String = 'play';
	var showCursor: Bool = true;

	public static var w: Int = 1280;
	public static var h: Int = 720;

	public static var state: States;
	public static var farglib: Array<Color>;

	override function config(config:luxe.AppConfig):luxe.AppConfig {

        if(config.runtime.window != null) {
            if(config.runtime.window.width != null) {
                config.window.width = Std.int(config.runtime.window.width);
            }
            if(config.runtime.window.height != null) {
                config.window.height = Std.int(config.runtime.window.height);
            }
        }

		config.preload.textures = [
			{id: 'assets/logo_box.png'}
		];

		return config;
	}

	override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle( 0, 0, e.event.x, e.event.y);
    }

	override function ready() {

		Luxe.camera.size = new Vector(Main.w, Main.h);
		Luxe.camera.size_mode = SizeMode.fit;

		Luxe.renderer.clear_color = new Color().rgb(0xeeeeee);

		state = new States( { name: "states" } );

		state.add (new states.Play({name: 'play'}));
		state.add (new states.Menu({name: 'menu'}));
		state.add (new states.End({name: 'end'}));
		state.add (new states.Splash({name: 'splash'}));

		state.set(initialState);
		state.enable('menu');

		farglib = [
			new Color().rgb(0xff007b), //stylish red
			new Color().rgb(0x007bff), //stylish blue
			new Color().rgb(0xACE1AF), // celadon
			new Color().rgb(0xff7b00), //stylish orange
			new Color().rgb(0xB57EDC), // lavender
			new Color().rgb(0x4D5D53), // feldgrau
			new Color().rgb(0xB6564D), // rich lilac
			new Color().rgb(0x81D8D0), // tiffany blue
			new Color().rgb(0xF8DE7E), // jasmine
			new Color().rgb(0xE52B50), // amaranth
		];

		// setupEvents();
	}

	// public function setupEvents() {

	// 	Luxe.events.listen('game.ends', function(_e: EndEvent){
	// 		state.enable('end');
	// 	}); 

	// }

}

typedef EndEvent = {
	arque: Bool,
	draw: Bool,
	azurwins: Bool
}
