package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import nape.phys.Body;
// import nape.phys.Shape;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

import nape.geom.Vec2;
import nape.shape.Shape;

import nape.callbacks.CbType;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;
import C;

typedef ArmOptions = {
	> ComponentOptions,

	var x: Float;
	var y: Float;
	var rot: Float;
	// var shape: Array<nape.geom.Vec2>;
	var shape: Shape;
	var cbType: CbType;
}

// Base class for armor/firearm components,
// including farger mainbody, (bilaterial) armlets, shield and arquen
class ArmBase extends Component {

	public var body: Body;
	public var hitShardListener: InteractionListener;

	public var detached: Bool = false;

	
	override public function new (_options: ArmOptions) {

		super(_options);

		// Basic settings
		body = new Body(BodyType.DYNAMIC);
		body.setShapeMaterials(new Material(0.0, 0.0, 0.0));
		body.space = Luxe.physics.nape.space;

		// Processing arguments
		body.shapes.add(_options.shape);
		body.position.setxy(Main.w * _options.x, Main.h * _options.y);
		body.rotation = _options.rot;
		if (_options.cbType != null) body.cbTypes.add( _options.cbType );

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		hitShardListener = new InteractionListener( CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.armlet,
			PhysTypes.shard,
			hitShard
		);
		Luxe.physics.nape.space.listeners.add(hitShardListener);
	}

	@:noCompletion public function hitShard( callback: InteractionCallback ) {}

}