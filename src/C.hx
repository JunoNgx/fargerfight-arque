package;

import nape.shape.Polygon;

class C {

	// Touch control
	public static var double_tap: Float = 0.3;
	public static var force_multiplier: Float = 12;
	public static var angularVel_multiplier: Float = 3;

	// Impact forces upon breakage of joints
	public static var if_armlet: Float = 700;

	public static var fire_cooldown: Float = 0.75;
	public static var barrel_length: Float = 128;

	public static var shard_radius: Float = 20;
	public static var shard_lifetime: Float = 2;
	public static var shard_speed: Float = 500;

	// Prop
	public static var essence_pos_variance: Float = 64;
	public static var essence_scale_min: Float = 0.2;
	public static var essence_scale_max: Float = 1;


	public static var body_armlet: Array<nape.geom.Vec2> = Polygon.box( 64, 5);
	public static var body_farger: Array<nape.geom.Vec2> = Polygon.regular(48, 48, 3, Math.PI);
	public static var body_shield: Array<nape.geom.Vec2> = Polygon.box( 12, 66);
	public static var body_arquen: Array<nape.geom.Vec2> = Polygon.regular(10, 10, 12); // A polygon with high amount of vertex to simulate a circle, for simplicity's sake

}