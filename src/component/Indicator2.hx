package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

import C;
import entity.PlayerBase;

// HP indicator
class Indicator2 extends Component {

	// hp indicator runs clockwise
	var h1: Sprite;
	var h2: Sprite;
	var h3: Sprite;
	var h4: Sprite;

	override function init() {
		var host: Sprite = cast entity;

		h1 = new Sprite({
			name_unique: true,
			pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians), host.pos.y + C.indicator_radius * Math.sin(host.radians)),
			radians: host.radians + Math.PI/4,
			size: new Vector(C.indicator_size, C.indicator_size)
		});

		h2 = new Sprite({
			name_unique: true,
			pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI/2), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI/2)),
			radians: host.radians + Math.PI/4,
			size: new Vector(C.indicator_size, C.indicator_size)
		});

		h3 = new Sprite({
			name_unique: true,
			pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI)),
			radians: host.radians + Math.PI/4,
			size: new Vector(C.indicator_size, C.indicator_size)
		});

		h4 = new Sprite({
			name_unique: true,
			pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI * 1.5), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI * 1.5)),
			radians: host.radians + Math.PI/4,
			size: new Vector(C.indicator_size, C.indicator_size)
		});
	}

	override function update(dt: Float) {
		var host: PlayerBase = cast entity;

		h1.pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians), host.pos.y + C.indicator_radius * Math.sin(host.radians));
		h1.radians = host.radians + Math.PI/4;

		h2.pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI/2), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI/2));
		h2.radians = host.radians + Math.PI/4;

		h3.pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI));
		h3.radians = host.radians + Math.PI/4;

		h4.pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI * 1.5), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI * 1.5));
		h4.radians = host.radians + Math.PI/4;

		if (h4 != null && host.hp < 4) h4.destroy;
		if (h3 != null && host.hp < 3) h3.destroy;
		if (h2 != null && host.hp < 2) h2.destroy;
		if (h1 != null && host.hp < 1) h1.destroy;

	}

}