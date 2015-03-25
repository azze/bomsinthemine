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
	public var inMsg:String = "";
	public var changes:Bool = false;
	public var outMsg:String = "";
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
		server.run("10.0.1.183", 5000);
		
	}
	public function relayGameInfo():Void 
	{
		while (true)
		{
			Thread.readMessage(true);
			if(outMsg.length>1){
				server.inform(outMsg);
				outMsg = "";
			}
			
	
		}
	}
	public function handleInput():Void
	{
		
		if (_player._up != FlxG.keys.anyPressed(["UP", "W"])) {
			_player._up = !_player._up;
			outMsg = outMsg + "u";
			outMsg = appendBool(outMsg,_player._up);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._down != FlxG.keys.anyPressed(["DOWN", "S"])) {
			_player._down = !_player._down;
			outMsg = outMsg + "d";
			outMsg = appendBool(outMsg, _player._down);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._left != FlxG.keys.anyPressed(["LEFT", "A"])) {
			_player._left = !_player._left ;
			outMsg = outMsg + "l";
			outMsg = appendBool(outMsg,_player._left );
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._right != FlxG.keys.anyPressed(["RIGHT", "D"])) {
			_player._right = !_player._right;
			outMsg = outMsg + "r";
			outMsg = appendBool(outMsg, _player._right);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._C != FlxG.keys.pressed.C) {
			_player._C = !_player._C;
			outMsg = outMsg + "c";
			outMsg = appendBool(outMsg, _player._C);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._X != FlxG.keys.justPressed.X) {
			_player._X = !_player._X;
			outMsg = outMsg + "x";
			outMsg = appendBool(outMsg, _player._X);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._V != FlxG.keys.pressed.V) {
			_player._V = !_player._V;
			outMsg = outMsg + "v";
			outMsg = appendBool(outMsg, _player._V);
			outMsg = outMsg + "\n";
			changes = true;
		}
		if (_player._space != FlxG.keys.pressed.SPACE) {
		
			_player._space = !_player._space;
			outMsg = outMsg + "q";
			outMsg = appendBool(outMsg, _player._space);
			outMsg = outMsg + "\n";
			changes = true;
		}
		
		sendCoordinates(_player);
	}
	public function sendCoordinates(o:Player) 
	{
		var s:String = Std.string(o.y).substr(0, 4);
		var r:String = Std.string(o.x).substr(0, 4);
		while (r.length < 4)
			r = "0" + r;
		while (s.length < 4)
			s = "0" + s;
			
		var uid:String = Std.string(o.id);
		while (uid.length < 3)
			uid = "0" + uid;
		var str:String = "3x2" + o.type+ uid +"p" + r + s + "\n";
		outMsg = outMsg+str;
	}
	public function appendBool(msg:String, bl:Bool):String
	{
		if (bl)
			msg = msg + "1";
		else
			msg = msg +"0";
		return msg;
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