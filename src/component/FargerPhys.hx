package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;

// typedef FargerPhys = {
// 	> ComponentOptions,

// 	var x: Float;
// 	var y: Float;
// }

class FargerPhys extends Component {

	public var body: Body;
	public var hitShardListener: InteractionListener;

	override public function new(_x: Float, _y: Float) {
		super({name: 'physic'});

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Polygon(Polygon.box(32, 64)));
		body.position.setxy(Main.w * _x, Main.y * _y);
		body.setShapeMaterials(new Material(0.0, 1.0, 2.0, 1.0, 0.1));
		body.cbTypes.add(PhysTypes.farger);
		body.space = Luxe.physics.nape.space;

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		//Collision callbacks
		hitShardListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.farger,
			PhysTypes.shard,
			hitShard
		);
		Luxe.physics.nape.space.listeners.add(hitShardListener);
	}

	function hitShard(callback: InteractionCallback) {
		var host: entity.PlayerBase = cast entity;
		host.hp -= 1;

		trace('lost 1 hp');

		// TODO Slowmo
		// TODO Impulse towards Farger
	}

	override public function update(dt: Float) {
		var host: luxe.Visual = cast entity;

		host.pos = new Vector( body.position.x, body.position.y);
		host.radians = body.rotation;
	}
}