package ;

/**
 * ...
 * @author ...
 */
class Stone extends Rock
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.stone__png, true, 16, 16);
		this.density = 100;
		this.maxDensity = 100;
		this.dropChance = 0.05;
		
		type = 1;
	}
	
	override public function update():Void 
	{
		super.update();
		if (density / maxDensity < 0.5)
		{
			animation.frameIndex=1;
		}
		if (density / maxDensity < 0.25)
		{
			animation.frameIndex=2;
		}
	}
	
}