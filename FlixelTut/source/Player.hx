package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.system.FlxSound;




/** Variablen */

class Player extends FlxSprite
{
	
	public var speed:Float = 200;
	
	public var bombTimer:Float = 0;
	public var bombCooldown:Float = 10;
	
	public var attSpeed:Float = 1;
	public var attTimer:Float = 0;
	public var attacked:Bool = false;
	
	public var damage:Float = 10;
	
	public var bombs:FlxTypedGroup<Bomb> = new FlxTypedGroup<Bomb>();
	
	public var weapon:Int = 1;
	
	public var game:PlayState;
	public var sndMove:FlxSound;
	public var sndDrop:FlxSound;
	public var _up:Bool = false;
	public var _down:Bool = false;
	public var _left:Bool = false;
	public var _right:Bool = false;
	public var _X:Bool = false;
	public var _C:Bool = false;
	public var _V:Bool = false;
	public var _space:Bool = false;
	public var id = 0;
	public var type = 0;
	
	
	
	/**------ Its alive ------*/
	public function new(X:Float=0, Y:Float=0, gam:PlayState)  
	{
		super(X, Y);
		sndMove = FlxG.sound.load(AssetPaths.walk__wav);
		sndDrop = FlxG.sound.load(AssetPaths.drop__wav);
		game = gam;
	}
	
	
	
	
	/**------ and it can do stuff ------*/
	
	
	override public function update():Void 
	{
		movement();
		super.update();
		
		if (_C)
		{
			attack();
		}
		maxVelocity = new FlxPoint(100, 100);
		if (attTimer > 0) {
			attTimer = attTimer -FlxG.elapsed;
		}
		if (_V)
		{
			setBomb();
		}
		if (_X)
		{
			changeWeapons();
		}
		if (bombTimer > 0)
		{
			bombTimer = bombTimer -FlxG.elapsed;
				
		}
	}
	
	
	
	
	/**------ it can move ------*/
	
	private function movement():Void
	{
		
		
		
		if (_up || _down || _left || _right) {
			
			if (_up && _down)
				_up = _down = false;
				
			if (_left && _right)
				_left = _right = false;
				
			var mA:Float = 0; 
			if (_up)  
			{
				mA = -90; 
				if (_left)
					mA -= 45; 
				else if (_right)
					mA += 45; 
				facing = FlxObject.UP; 
			}
			else if (_down) 
			{
				mA = 90;
				if (_left)
					mA += 45; 
				else if (_right)
					mA -= 45; 
				facing = FlxObject.DOWN; 
			}
			else if (_left) 
			{
				mA = 180; 
				facing = FlxObject.LEFT; 
			}
			else if (_right) 
			{
				mA = 0; 
				facing = FlxObject.RIGHT; 
			}
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity); 
			sndMove.play();
		}
	}
	
	
	
	/**------ it hits pretty hard ------*/
	
	public function attack():Void {
		if (attTimer <= 0)
		{
			attacked = true;
			attTimer = attSpeed;
		}
						
	}
	
	/**------ it like stuff that goes boom ------*/
	
	public function setBomb():Void
	{
		if (bombTimer <= 0)
		{
			
			
			var point:FlxPoint = new FlxPoint(getMidpoint().x, getMidpoint().y);
			point = snapToGrid(point);
			sndDrop.play();
			
			switch(weapon)
				{
					case 1:
						bombs.add(new SmallBomb (point.x, point.y));
						bombTimer = bombCooldown;
						
						
					case 2:
						bombs.add(new BigBomb (point.x, point.y));
						bombTimer = bombCooldown;
				}
		}
	}
	
	/**------ these bombs behave strange ------*/
	
	public function snapToGrid(pt:FlxPoint ):FlxPoint
	{
		var pnt:FlxPoint = new FlxPoint((Math.floor(pt.x/16) * 16), Math.floor(pt.y / 16) * 16);
		return pnt;
	}
	
	public function changeWeapons():Void
	{
		if (weapon == 1)
		{
			weapon++;
		}
		else
		{
			weapon--;
		}
	}
	
	
}