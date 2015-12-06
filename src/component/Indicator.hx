package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

import C;
import entity.PlayerBase;

// HP indicator
class Indicator extends Component {

	var hi: Array<Sprite>; // health indicator

	override function init() {
		hi = new Array<Sprite>();

		var host: Sprite = cast entity;

		for (i in 0...4) { // TODO why doesn't 3 work?
			hi[i] = new Sprite({
				name_unique: true,
				pos: new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI/2 * i), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI/2 * i)),
				// radians: host.radians + Math.PI/4,
				size: new Vector(C.indicator_size, C.indicator_size)
			});
		}
	}

	override function update(dt: Float) {
		var host: PlayerBase = cast entity;

		for (i in 0...hi.length) {
			hi[i].pos = new Vector (host.pos.x + C.indicator_radius * Math.cos(host.radians + Math.PI/2 * i), host.pos.y + C.indicator_radius * Math.sin(host.radians + Math.PI/2 * i));
			hi[i].radians = host.radians + Math.PI/4;

			if (host.hp < (i+1) && hi[i] != null) hi[i].destroy();
		}

	}

}