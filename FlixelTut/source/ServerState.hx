package ;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import neko.vm.Thread;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxPoint;
/**
 * ...
 * @author azze
 */
class ServerState extends PlayState
{
	public var server:Server;
	public var serverThread:Thread;
	public var runServer:Thread;
	private var _map:FlxOgmoLoader;
	private var _mGround:FlxTilemap;
	public var message:String="";
	
	override public function create():Void 
	{
		trace(gameType);
		_map = new FlxOgmoLoader(AssetPaths.minelvl002__oel);
		_mGround = _map.loadTilemap(AssetPaths.Game_Template_Tiles_v1__png, _gridSize, _gridSize, "ground");
		_mGround.setTileProperties(1, FlxObject.NONE);
		_mGround.setTileProperties(2, FlxObject.ANY);
		add(_mGround);
		super.create();
		if (gameType == 1) {
			server = new Server();
			server.state = this;
			serverThread = Thread.create(relayGameInfo);
			runServer = Thread.create(runIt);
		}
		
		switch(playerClass){
			case 0:
				addPlayer(new Jim(0, 0, this));
			case 1:
				addPlayer(new Sid(0, 0, this));
			case 2:
				addPlayer(new Trevor(0, 0, this));
		}
		_player = _grpPlayer.members[0];
		add(_player.bombs);
		
		_map.loadEntities(placeEntities, "entities");
	}
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		 if (entityName == "rocks")
		{
			addRock(new Stone(x, y));
		}
		else if (entityName == "gold")
		{
			addGold(new Gold(x, y));
		}
	}
	override public function update():Void
	{
		super.update();
		FlxG.collide(_grpPlayer, _grpStones);
		for(ply in _grpPlayer){
			_weapons = ply.weapon;
		
			if (ply.bombTimer != 0)
			{
			
				_ready =Std.int(ply.bombTimer +1) ;
			}
		
			/**--- this sword is heavy---*/
			if (ply.attacked) {
				var obj:FlxObject;
				switch(ply.facing){
					case FlxObject.LEFT:
						obj= new FlxObject(ply.getMidpoint().x-_gridSize, ply.getMidpoint().y);
					case FlxObject.UP:
						obj= new FlxObject(ply.getMidpoint().x, ply.getMidpoint().y - _gridSize);
			
					case FlxObject.RIGHT:
						obj= new FlxObject(ply.getMidpoint().x+ _gridSize, ply.getMidpoint().y );

					case FlxObject.DOWN:
						obj= new FlxObject(ply.getMidpoint().x, ply.getMidpoint().y + _gridSize);
					default:
						obj= new FlxObject(ply.getMidpoint().x, ply.getMidpoint().y );
				}
				FlxG.overlap(obj, _grpStones, attackStone);
				obj.kill();
			
				ply.attacked = false;
				
			}
			/**---"First shalt thou take out the Holy Pin, then shalt thou count to three, no more, no less. 
			* 	   Three shall be the number thou shalt count, and the number of the counting shall be three.
			* 	   Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. 
			*     Five is right out. Once the number three, being the third number, be reached, 
			*     then lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who being naughty in My sight, 
			*     shall snuff it."---*/
			for (i in 0...ply.bombs.members.length)
			{
				var bob:Bomb = ply.bombs.members[i];
				if (bob.exploded)
				{
					sndExplosion.play();
					for (j in 0..._grpStones.length)
					{	
						if(_grpStones.members[j].alive){
							var poin:FlxPoint = _grpStones.members[j].getMidpoint();
						
							var dist:Float = distance(poin, bob.getMidpoint());
							if (dist < bob.radius) {
								_grpStones.members[j].damage(bob.damage * (bob.radius - dist) / bob.radius);
								if (!_grpStones.members[j].alive)
									removeRock(_grpStones.members[j]);
							}
						}
					}
					
					var poin2:FlxPoint = ply.getMidpoint();
					var dist2:Float = distance(poin2, bob.getMidpoint());
				
					if (dist2 < bob.radius) {
						playerDamage(bob.damage * (bob.radius - dist2) / bob.radius);
					}
					bob.kill();
					bob.exploded = false;
					bob.destroy();
					
				}
			}
			FlxG.overlap(ply, _grpGold, pickGold);
			FlxG.overlap(ply, _grpGems, pickGem);
		}
		FlxG.overlap(_grpProjectile, _grpStones, hitStone);
		
		handleInput();
		if (message.length > 7)
		{
			var ply:Player = _grpPlayer.members[1];
			ply._up = intToBool(message.charAt(0));
			ply._down = intToBool(message.charAt(1));
			ply._left = intToBool(message.charAt(2));
			ply._right = intToBool(message.charAt(3));
			ply._C = intToBool(message.charAt(4));
			ply._V = intToBool(message.charAt(5));
			ply._X = intToBool(message.charAt(6));
			ply._space = intToBool(message.charAt(7));
		}
		
		
		if (gameType == 1) {
			
			serverThread.sendMessage("hi");
		}
	}
	public function intToBool(a:String):Bool
	{
		if (a == "0")
			return false;
		else
			return true;
	}
	public function runIt():Void 
	{
		trace("starting server...");
		server.run("192.168.178.20", 5000);
		
	}
	public function relayGameInfo():Void 
	{
		while (true)
		{
			Thread.readMessage(true);
			for(o in _grpPlayer){
				var s:String = Std.string(o.y).substr(0, 4);
				var r:String = Std.string(o.x).substr(0, 4);
				while (r.length < 4)
					r = "0" + r;
				while (s.length < 4)
					s = "0" + s;
			
				var uid:String = Std.string(o.id);
				while (uid.length < 3)
					uid = "0" + uid;
				var str:String = "3x2"+o.type+ uid +"p" + r + s + "\n";
				server.inform(str);
			}
	
		}
	}
	public function handleInput():Void
	{
		_player._up = FlxG.keys.anyPressed(["UP", "W"]);
		_player._down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_player._left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_player._right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		_player._C = FlxG.keys.pressed.C;
		_player._X = FlxG.keys.justPressed.X;
		_player._V = FlxG.keys.pressed.V;
		_player._space = FlxG.keys.pressed.SPACE;
	}
	
	public function playerDamage(dam:Float=0)
	{
		
		_health = (Math.round(_health - dam));
	
	}
	
	public function hitStone(P:Projectile, R:Rock)
	{
		R.damage(P.power);
		if (!R.alive)
			removeRock(R);
		P.destroy();
	}
	
	/**----- Uh how far away is this thing?-----*/
	public function distance(p1:FlxPoint, p2:FlxPoint):Float
	{
		var a = Math.abs(p1.x - p2.x);
		var b = Math.abs(p1.y - p2.y);
		return Math.sqrt(a * a + b * b);
	}
	/**----- Nice and Shiny -----*/
	
		public function pickGem(O:Player, C:Gem)
	{
		removeGem(C);
	}
	
	public function pickGold(O:Player, G:Gold)
	{
		_money++;
		sndCoin.play();
		removeGold(G);
	}
	/**----- Take that you stupid Stone -----*/
	public function attackStone(O:FlxObject, R:Rock)
	{
		sndHit.play();
		R.damage(_player.damage);
		if (!R.alive)
			removeRock(R);
	}
	
	
	
	
	
}