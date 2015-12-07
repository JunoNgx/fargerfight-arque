package;

import nape.callbacks.CbType;

class PhysTypes {

	// Entity physic type
	public static var shard: CbType = new CbType();
	public static var farger: CbType = new CbType();
	public static var arquen: CbType = new CbType();
	public static var shield: CbType = new CbType();
	public static var armlet: CbType = new CbType();
	public static var border: CbType = new CbType();

	// PhysTypes.armbase's sole purpose is to create a 
	// collision callback in which audio will be played upon 
	// body parts colliding with the walls,  
	// for an enhanced feedback when arque is achieved in a match

	// so much for just entertaining the player
	public static var armbase: CbType = new CbType();
}