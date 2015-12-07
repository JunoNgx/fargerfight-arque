package;

import luxe.Screen.WindowEvent;
import luxe.Vector;
import luxe.Color;
import luxe.Camera;

import luxe.States;
import phoenix.BitmapFont;

class Main extends luxe.Game {

	var initialState: String = 'play';
	var showCursor: Bool = true;

	public static var w: Int = 1280;
	public static var h: Int = 720;

	public static var state: States;
	public static var farglib: Array<Color>;

	public static var raleway32: BitmapFont;

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
			{id: 'assets/logo_luxe.png'},
			{id: 'assets/logo_aureotetra.png'},

			{id: 'assets/backgroundtile.png'},
			{id: 'assets/arque_title.png'},
			{id: 'assets/button_play.png'},
			{id: 'assets/button_reset.png'},
			{id: 'assets/banner_wins.png'},
			{id: 'assets/banner_draw.png'},
			{id: 'assets/banner_arque.png'},

			{id: 'assets/farger_entity.png'},
			{id: 'assets/farger_phys.png'},
			{id: 'assets/armlet_rt.png'},
			{id: 'assets/armlet_lt.png'},
			{id: 'assets/shield.png'},
			{id: 'assets/arquen.png'},
			{id: 'assets/shard.png'},
		];

		config.preload.fonts.push({id: 'assets/raleway32.fnt'});

		return config;
	}

	override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle( 0, 0, e.event.x, e.event.y);
    }

	override function ready() {

		Luxe.camera.size = new Vector(Main.w, Main.h);
		Luxe.camera.size_mode = SizeMode.fit;

		Luxe.renderer.clear_color = new Color().rgb(0xeeeeee);
		
		raleway32 = Luxe.resources.font('assets/raleway32.fnt');

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

		state = new States( { name: "states" } );

		state.add (new states.Play({name: 'play'}));
		state.add (new states.Menu({name: 'menu'}));
		// state.add (new states.End({name: 'end'}));
		// state.add (new states.Splash({name: 'splash'}));

		state.set(initialState);
		state.enable('menu');

		setupAudio();
	}

	function setupAudio() {
		Luxe.audio.create('assets/arque_pa.ogg', 'arque_pa');
		Luxe.audio.create('assets/arque_impact.ogg', 'arque_impact');
		Luxe.audio.create('assets/fire.ogg', 'fire');

		// shard hitting armlet
		Luxe.audio.create('assets/hit_armlet.ogg', 'hit_armlet');

		// shard hitting main body
		Luxe.audio.create('assets/hit_impact.ogg', 'hit_impact');
		Luxe.audio.create('assets/hit_notif.ogg', 'hit_notif');
		Luxe.audio.create('assets/hit_die.ogg', 'hit_die');

		// the impact between the walls and shards
		Luxe.audio.create('assets/border_shard1.ogg', 'border_shard1');
		Luxe.audio.create('assets/border_shard2.ogg', 'border_shard2');
		Luxe.audio.create('assets/border_shard3.ogg', 'border_shard3');
		Luxe.audio.create('assets/border_shard4.ogg', 'border_shard4');

		// the impact between the walls and body parts
		Luxe.audio.create('assets/border_armbase1.ogg', 'border_armbase1');
		Luxe.audio.create('assets/border_armbase2.ogg', 'border_armbase2');
		Luxe.audio.create('assets/border_armbase3.ogg', 'border_armbase3');
	}

}

typedef EndEvent = {
	arque: Bool,
	draw: Bool,
	azurwins: Bool
}
