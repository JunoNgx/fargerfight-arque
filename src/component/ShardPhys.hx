package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

class ShardPhys extends Component {

	public var body: Body;

	override public function new() {
		super({name: 'physic'});

		body = new Body(BodyType.KINEMATIC);
		body.shapes.add(new Polygon(Polygon.regular(24, 24, 3)));
		body.setShapeMaterials(new Material(0.0, 1.0, 2.0, 1.0, 0.1));
		body.space = Luxe.physics.nape.space;
		states.Play.drawer.add(body);
	}

	override public function update(dt: Float) {
		entity.pos = new Vector( body.position.x, body.position.y);
	}

}