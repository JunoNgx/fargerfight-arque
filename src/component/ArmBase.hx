package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Sprite;

import nape.phys.Body;
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
	var shape: Array<nape.geom.Vec2>;
	var cbType: CbType;
	@:optional var texture: phoenix.Texture;
	@:optional var color: luxe.Color;
}

// Base class for armor/firearm components,
// including farger mainbody, (bilaterial) armlets, shield and arquen
class ArmBase extends Component {

	public var body: Body;
	public var hitShardListener: InteractionListener;
	public var hitBorderListener: InteractionListener;

	public var gfx: Sprite;

	public var detached: Bool = false;

	
	override public function new (_options: ArmOptions) {

		super(_options);

		// Basic settings
		body = new Body(BodyType.DYNAMIC);
		body.setShapeMaterials(new Material(0.0, 0.0, 0.0));
		body.space = Luxe.physics.nape.space;

		// Processing arguments
		body.shapes.add(new Polygon(_options.shape));
		body.position.setxy(Main.w * _options.x, Main.h * _options.y);
		body.rotation = _options.rot;
		if (_options.cbType != null) body.cbTypes.add( _options.cbType );
		
		body.cbTypes.add(PhysTypes.armbase);

		// Graphics
		gfx = new Sprite({
			name:'gfx',
			name_unique: true,
			pos: new luxe.Vector(this.body.position.x, this.body.position.y),
			rotation_z: this.body.rotation,
			depth: -4,
			texture: _options.texture,
			color: _options.color,
		});

		// Debug drawer
		if(states.Play.drawer != null) states.Play.drawer.add(body);

		hitShardListener = new InteractionListener( CbEvent.BEGIN, InteractionType.COLLISION,
			[PhysTypes.armlet, PhysTypes.farger, PhysTypes.arquen, PhysTypes.shield],
			PhysTypes.shard,
			hitShard
		);
		Luxe.physics.nape.space.listeners.add(hitShardListener);

		hitBorderListener = new InteractionListener( CbEvent.BEGIN, InteractionType.COLLISION,
			PhysTypes.armbase,
			PhysTypes.border,
			hitBorder
		);
		Luxe.physics.nape.space.listeners.add(hitBorderListener);
	}

	override function update(dt: Float) {
		gfx.pos = new luxe.Vector(this.body.position.x, this.body.position.y);
		gfx.radians = this.body.rotation;
	}

	function hitBorder(callback: InteractionCallback) {
		if(callback.int1.castBody.id == body.id) {
			var rando = Luxe.utils.random.int(1,4);
			switch rando {
				case 1: Luxe.audio.play('border_armbase1');
				case 2: Luxe.audio.play('border_armbase2');
				case 3: Luxe.audio.play('border_armbase3');
			}
		}
	}

	@:noCompletion public function hitShard( callback: InteractionCallback ) {}

}