package ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Projectile extends FlxSprite
{
	
	public var speed = 0;
	public var power = 0;
	public var id = 0;
	
	
	public function new(X:Float = 0, Y:Float = 0) 
	
	{
		super(X, Y);
		
	}
	
}