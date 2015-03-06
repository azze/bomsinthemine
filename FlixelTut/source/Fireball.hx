package ;

/**
 * ...
 * @author ...
 */
class Fireball extends Projectile
{
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.fireball__png, false, 16, 16);
		speed = 500;
		power = 350;
	}
	
}