package ;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxObject;
/**
 * ...
 * @author ...
 */
class Jim extends Player
{

	public var barrierTimer:Float = 0;
	public var barrierCD:Float = 4;
	
	public function new(X:Float=0, Y:Float=0, game:PlayState) 
	{
		super(X, Y, game);
		type = 1;
		loadGraphic(AssetPaths.Game_Template_Miner_v2__png, false, 16, 16);
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
	
	override function movement():Void
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
	public function barrier():Void
	{
		var point:FlxPoint; 
			switch(facing) {
				case FlxObject.LEFT:
					point = new FlxPoint(getMidpoint().x+game._gridSize, getMidpoint().y);
					point = snapToGrid(point);
					
					game.addRock(new Iron(point.x, point.y));	
					point.y = point.y + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.UP:
					point = new FlxPoint(getMidpoint().x, getMidpoint().y+game._gridSize);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.RIGHT:
					point = new FlxPoint(getMidpoint().x-game._gridSize, getMidpoint().y);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.DOWN:
					point = new FlxPoint(getMidpoint().x, getMidpoint().y-game._gridSize);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				default:
			}
	}
	
	override public function update():Void
	{
		super.update();
		if (_space)
		{
			if(barrierTimer<=0){
				barrier();
				barrierTimer = barrierCD;
			}
		}
		if (barrierTimer > 0) {
			barrierTimer -= FlxG.elapsed;
		}
	}
	
}