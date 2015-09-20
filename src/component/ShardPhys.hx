package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
// import nape.shape.Polygon;
import nape.shape.Circle;

// import nape.geom.Geom;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;

import PhysTypes;

class ShardPhys extends Component {

	public var body: Body;
	public var hitFargerCallback: InteractionListener;

	override public function new() {
		super({name: 'physic'});

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Circle(24));
		body.setShapeMaterials(new Material(1.0, 0.1, 1, 0.05, 0.1));
		body.cbTypes.add(PhysTypes.shard);
		body.space = Luxe.physics.nape.space;

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		//Collision callback
		hitFargerCallback = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.shard,
			PhysTypes.farger,
			hitFarger
		);
		Luxe.physics.nape.space.listeners.add(hitFargerCallback);
	}

	function hitFarger(callback: InteractionCallback) {
		// TODO Bloodsplash based on this one's rotation
		hostDestroy();
	}

	function hitArmor(callback: InteractionCallback) {
		// TODO Spark based on this one's rotation
		hostDestroy();
	}

	function hitArquen(callback: InteractionCallback) {
		// TODO heavy bloodsplash based on this one's rotation
		// TODO Luxe.events.fire('arque')
		hostDestroy();
	}

	function hostDestroy() {
		var host: entity.Shard = cast entity;
		host.destroy();
	}

	override public function update(dt: Float) {
		entity.pos = new Vector( body.position.x, body.position.y);

		var host: luxe.Visual = cast entity;
		host.radians = this.body.rotation;
		// collideWithCovers();
	}

	// function collideWithCovers() {
	// 	// if (Geom.intersectsBody(this.body, states.Play.borders)) {
	// 	for (ownShape in body.shapes) {
	// 		for (covShape in states.Play.borders.shapes) {
	// 			if (Geom.intersects(ownShape, covShape)) {
	// 				trace('hit');
	// 			}
	// 		}
	// 	}
		
	// 		// trace('hit');
	// 	// }
	// }

}