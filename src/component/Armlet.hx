package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

import nape.geom.Vec2;

import nape.constraint.WeldJoint;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;

class Armlet extends Component {

	public var body: Body;
	public var hitShardListener: InteractionListener;
	public var constraint: WeldJoint;
	
	override public function new () {

		super({
			name: 'armlet'
		});

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add( new Polygon (Polygon.box( 24, 12)));
		body.cbTypes.add( PhysTypes.armlet);
		body.space = Luxe.physics.nape.space;

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		// Collision callbacks
		hitShardListener = new InteractionListener( CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.armlet,
			PhysTypes.shard,
			hitShard
		);

		var host: entity.PlayerBase = cast entity;

		// // Constraint construction
		// constraint = new WeldJoint(
		// 	this.body,
		// 	host.phys.body,
		// 	new Vec2(0,0),
		// 	new Vec2(0,0),
		// 	0
		// );
	}

	function hitShard(callback: InteractionCallback) {
		if (states.Play.drawer != null) states.Play.drawer.remove(this.body);
		Luxe.physics.nape.space.bodies.remove(this.body);
		entity.remove(this.name);
	}

	override public function init() {

	}

}