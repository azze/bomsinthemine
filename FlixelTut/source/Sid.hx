package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
/**
 * ...
 * @author ...
 */
class Sid extends Player
{
	
	public var blinkTimer:Float = 0;
	public var blinkCD:Float = 3;
	public function new(X:Float=0, Y:Float=0, gam:PlayState) 
	{
		super(X, Y, gam);
		loadGraphic(AssetPaths.Game_Template_Miner_Sid__png, false, 16, 16);
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
			if(blinkTimer<=0){
				blink();
				blinkTimer = blinkCD;
			}
		}
		if (blinkTimer > 0) {
			blinkTimer -= FlxG.elapsed;
		}
	}
	
	public function blink():Void
	{
		var a:Int = 8;
		switch(facing) {
			case FlxObject.LEFT:
				while (game.checkGrid(x - game._gridSize * a, y))
					a = a - 1;
				x = x - game._gridSize*a;
			case FlxObject.UP:
				while (game.checkGrid(x , y- game._gridSize * a))
					a = a - 1;
				y = y -game._gridSize*a;
			case FlxObject.RIGHT:
				while (game.checkGrid(x + game._gridSize * a, y))
					a = a - 1;
				x = x +game._gridSize * a;
			case FlxObject.DOWN:
				while (game.checkGrid(x , y+ game._gridSize * a))
					a = a - 1;
				y = y + game._gridSize*a;
			default:
		}
	}
	
}