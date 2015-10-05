package;

import nape.shape.Polygon;

class C {

	public static var force_multiplier: Float = 5.5;

	public static var fire_cooldown: Float = 0.75;
	public static var barrel_length: Float = 128;

	public static var shard_lifetime: Float = 10;
	public static var shard_speed: Float = 500;

	public static var body_armlet: Array<nape.geom.Vec2> = Polygon.box( 64, 24);

}