package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxAngle;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import neko.vm.Thread;
import sys.db.Types.SId;
import sys.net.Host;
import sys.net.Socket;
import sys.net.UdpSocket;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _hud:HUD;
	private var _money:Int = 0;
	private var _health:Float = 100;
	private var _weapons:Int = 1;
	private var _ready:Int = 0;
	private var _player:Player;
	
	public var nextRockID:Int = 0;
	public var nextProjectileID:Int = 0;
	public var nextGoldID:Int = 0;
	public var nextGemID:Int = 0;
	public var nextPlayerID:Int = 0;
	public var _grpStones:FlxTypedGroup<Rock>;
	public var _grpGold:FlxTypedGroup<Gold>;
	public var _grpGems:FlxTypedGroup<Gem>;
	public var _grpProjectile:FlxTypedGroup<Projectile>;
	public var _grpPlayer:FlxTypedGroup<Player>;
	public var playerClass = 0;
	public var _gridSize:Int = 16;
	public var _grid:Array<Array<Bool>>;
	public var gameType:Float = 0; 
	public var sndExplosion:FlxSound;
	public var sndCoin:FlxSound;
	public var sndHit:FlxSound;
	
	/**----------------------------- Genesis -----------------------------*/
	
	/**---------------- first second and third day ----------------*/
	
	override public function create():Void
	{
		super.create();
		sndExplosion = FlxG.sound.load(AssetPaths.Explosion__wav);
		sndCoin = FlxG.sound.load(AssetPaths.Pickup_Coin__wav);
		sndHit = FlxG.sound.load(AssetPaths.Hit_Hurt2__wav);
		
		
		_grid = [for (i in 0...60) [for (j in 0...40) false]]; 
		
		_grpStones = new FlxTypedGroup<Rock>();
		_grpGold = new FlxTypedGroup<Gold>();
		_grpGems = new FlxTypedGroup<Gem>();
		_grpProjectile = new FlxTypedGroup<Projectile>();
		_grpPlayer = new FlxTypedGroup<Player>();
		add(_grpStones);
		add(_grpGold);
		add(_grpGems);
		add(_grpProjectile);
		add(_grpPlayer);
		_hud = new HUD();
		add(_hud);
		
		
		
	}
	
	
	/**---------------- Reality and all its things ----------------*/
	
	override public function update():Void
	{
		super.update();
		_hud.updateHUD(Math.floor(_player.HP), _player.cash, _weapons, _ready);
	}
	
	/**-----------------------Funktions Funktionen :P ------------------------*/
	
	
	public function checkGrid(i:Float = 0, j:Float = 0):Bool 
	{
		var r:Int = Math.floor(i / 16);
		var s:Int = Math.floor(j / 16);
		return _grid[r][s];
	}
	
	public function setGrid(i:Float = 0, j:Float = 0, bl:Bool=false):Void
	{
		_grid[Math.floor(i / 16)][Math.floor(j / 16)] = bl;
	}

	
	
	public function removeRock(R:Rock)
	{
		setGrid(R.x, R.y, false);
		if ((Math.random() < R.dropChance))
			addGold(new Gold(R.x, R.y));
		if ((Math.random() < (R.dropChance/10)))
			addGem(new Gem(R.x, R.y));
		R.destroy();
		R.kill();
	}
	public function removeGold(G:Gold)
	{
		setGrid(G.x, G.y, false);
		G.destroy();
		G.kill();
	}
	public function removeGem(G:Gem)
	{
		setGrid(G.x, G.y, false);
		G.destroy();
		G.kill();
	}
	public function addRock(R:Rock) {
		R.id = nextRockID;
		nextRockID = nextRockID + 1;
		if (!checkGrid(R.x, R.y)) {
			setGrid(R.x, R.y, true);
			_grpStones.add(R);
		}
	}
	public function addGold(G:Gold) {
		G.id = nextGoldID;
		nextGoldID = nextGoldID + 1;
		if (!checkGrid(G.x, G.y)) {
			setGrid(G.x, G.y, true);
			_grpGold.add(G);
		}
	}
	
	public function addGem(C:Gem) {
		C.id = nextGemID;
		nextGemID = nextGemID + 1;
		if (!checkGrid(C.x, C.y)) {
		setGrid(C.x, C.y, true);
		_grpGems.add(C);
		
		}
	}
	public function addPlayer(P:Player) {
		P.id = nextPlayerID;
		nextPlayerID = nextPlayerID + 1;
		_grpPlayer.add(P);
		trace("player added: " + P.id);
		if (nextPlayerID == 1) {
			P.x = 200;
			P.y = 400;
		}
		else if (nextPlayerID == 2) {
			P.x = 300;
			P.y = 400;
		}
	}
	/**----------------------------- Armageddon -----------------------------*/
	/** (Function that is called when this state is destroyed - you might want to 
	 consider setting all objects this state uses to null to help garbage collection.)*/
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	
	
	
	
	
}