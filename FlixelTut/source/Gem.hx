package ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Gem extends FlxSprite
{
	public var id = 0;

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.gem__png, true, 16, 16);
	}
	
}