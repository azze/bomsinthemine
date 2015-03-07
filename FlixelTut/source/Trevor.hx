package ;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
/**
 * ...
 * @author ...
 */
class Trevor extends Player
{
	public var ballTimer:Float = 0;
	public var ballCD:Float = 7;
	public function new(X:Float=0, Y:Float=0, gam:PlayState) 
	{
		super(X, Y, gam);
		loadGraphic(AssetPaths.Game_Template_Miner_Trevor__png, false, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("d", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("lr", [0, 1, 0, 2], 6, false);
		animation.add("da", [3, 11, 3, 12], 6, false);
		animation.add("ua", [6, 13, 6, 14], 6, false);
		animation.add("lra", [0, 9, 10, 9], 6, false);
		drag.x = drag.y = 16000;
		setSize(8, 14);
		offset.set(4, 2);
	}
	override public function attack():Void
	{
		switch(facing)
				{
					case FlxObject.LEFT:
						animation.play("lra");
						
						
					case FlxObject.RIGHT:
						animation.play("lra");
						
						
					case FlxObject.UP:
						animation.play("ua");
						
						
					case FlxObject.DOWN:
						animation.play("da");
						
				}
				super.attack();
	}
	override public function movement():Void
	{
		super.movement();
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) 
			{
				switch(facing)
				{
					case FlxObject.LEFT:
						animation.play("lr");
						
						
					case FlxObject.RIGHT:
						animation.play("lr");
						
						
					case FlxObject.UP:
						animation.play("u");
						
						
					case FlxObject.DOWN:
						animation.play("d");
						
				}
			}
	}
	override public function update():Void 
	{
		super.update();
		if (FlxG.keys.pressed.SPACE)
		{
			if(ballTimer<=0){
				ball();
				ballTimer = ballCD;
			}
		}
		if (ballTimer > 0) {
			ballTimer -= FlxG.elapsed;
		}
	}
	public function ball():Void
	{
		
		var locPoint:FlxPoint; 
		var ang:Float=0;
		switch(facing) {
			case FlxObject.LEFT:
				locPoint = new FlxPoint(x-game._gridSize, y);
				
				ang = 180;
					
			case FlxObject.UP:
				locPoint = new FlxPoint(x, y-game._gridSize);
				
				ang = -90;
				
			case FlxObject.RIGHT:
				locPoint = new FlxPoint(x+game._gridSize, y);
				
				ang = 0;
				
			case FlxObject.DOWN:
				locPoint = new FlxPoint(x, y+game._gridSize);
				
				ang = 90;
				
			default:
				locPoint = new FlxPoint(0, 0);
		}
		var fball:Fireball = new Fireball(locPoint.x, locPoint.y);
		game._grpProjectile.add(fball);
		FlxAngle.rotatePoint(fball.speed, 0, 0, 0, ang, fball.velocity); 
	}
	
}