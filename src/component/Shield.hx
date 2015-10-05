package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

import nape.geom.Vec2;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;

typedef ArquenOptions = {
	> ComponentOptions,

	var x: Float;
	var y: Float;
	var rot: Float;
}

class Shield extends Component {

	public var body: Body;
	// public var hitShardListener: InteractionListener;

	override public function new (_options: ArquenOptions) {
		super(_options);

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Polygon (Polygon.box(40, 12)));
		body.setShapeMaterials(new Material(0.0, 0.0, 0.0));
		body.cbTypes.add(PhysTypes.shield);
		body.space = Luxe.physics.nape.space;

		body.position.setxy (Main.w * _options.x, Main.h * _options.y);
		body.rotation = _options.rot;

		// hitShardListener = new InteractionListener (CbEvent.BEGIN, InteractionType.COLLISION,
		// 	PhysTypes.shield,
		// 	PhysTypes.shard,
		// 	hitShard
		// );
	}

	// function hitShard (callback: InteractionCallback) {
		
	// }

}