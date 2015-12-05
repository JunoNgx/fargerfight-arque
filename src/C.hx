package;

import nape.shape.Polygon;

class C {

	// Touch control
	public static var double_tap: Float = 0.3;
	public static var force_multiplier: Float = 17;
	public static var angularVel_multiplier: Float = 5;

	// Impact forces upon breakage of joints
	public static var if_armlet: Float = 700;
	public static var if_armbase: Float = 800; // for shield and arquen upon death
	public static var if_angular_multiplier: Float = 3;

	public static var fire_cooldown: Float = 0.75;
	public static var barrel_length: Float = 80;
	public static var barrel_angle: Float = 0.21; // angle multiplier

	public static var shard_radius: Float = 10;
	public static var shard_lifetime: Float = 2;
	public static var shard_speed: Float = 70; // impulse/force being applied on shard upon being fired

	// Prop
	public static var essence_pos_variance: Float = 64;
	public static var essence_scale_min: Float = 0.2;
	public static var essence_scale_max: Float = 0.6;

	public static var essence_direction_variance: Float = Math.PI/8;
	public static var essence_splash_amt_min: Int = 15;
	public static var essence_splash_amt_max: Int = 25;
	public static var essence_splash_dist_figure: Int = 64;

	public static var essence_splash_heavy_amt_min: Int = 50;
	public static var essence_splash_heavy_amt_max: Int = 100;

	// Rules
	public static var draw_allowance: Float = 2; // The number of seconds to resolve a match as a draw when both players die 

	public static var body_armlet: Array<nape.geom.Vec2> = Polygon.box( 64, 5);
	public static var body_farger: Array<nape.geom.Vec2> = Polygon.regular(48, 48, 3, Math.PI);
	public static var body_shield: Array<nape.geom.Vec2> = Polygon.box( 12, 66);
	public static var body_arquen: Array<nape.geom.Vec2> = Polygon.regular(10, 10, 8); // A polygon with high amount of vertex to simulate a circle, for simplicity's sake

	// Other graphic values
	public static var cText: luxe.Color = new luxe.Color().rgb(0x222222);
	public static var cShard: luxe.Color = new luxe.Color().rgb(0x333333);
	public static var cSpark: luxe.Color = new luxe.Color().rgb(0x666666);

}