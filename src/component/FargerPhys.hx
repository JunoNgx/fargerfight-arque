package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.shape.Polygon;

class FargerPhys extends Component {

	public var body: Body;

	override public function new() {
		super({name: 'physic'});

		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Polygon(Polygon.box(32, 64)));
		// body.shapes.add(new nape.shape.Circle(48));
		// body.position.setxy(Main.w * 0.25, Main.h * 0.5);
		body.setShapeMaterials(new Material(0.0, 1.0, 2.0, 1.0, 0.1));
		// body.setShapeMaterials(Material.rubber());
		body.space = Luxe.physics.nape.space;
		states.Play.drawer.add(body);
	}

	override public function update(dt: Float) {
		var host: luxe.Visual = cast entity;

		// entity.pos = new Vector( body.position.x, body.position.y);
		// entity.radians = body.rotation;

		host.pos = new Vector( body.position.x, body.position.y);
		host.radians = body.rotation;
	}
}