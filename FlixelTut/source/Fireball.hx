package ;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Fireball extends Projectile
{
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.fireballa__png, false, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		animation.add("lr", [0, 1, 2, 3, 4], 30, true);
		animation.play("lr");
		
		speed = 400;
		power = 350;
	}
	
}