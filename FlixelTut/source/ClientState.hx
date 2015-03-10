package ;

import flixel.FlxSprite;
import flixel.FlxState;
import sys.net.Host;
import sys.net.UdpSocket;
import neko.vm.Thread;
import flixel.group.FlxTypedGroup;
import neko.Lib;

/**
 * ...
 * @author ...
 */
class ClientState extends FlxState
{
	var _player:FlxSprite;
	var client:Client;
	var clientThread:Thread;
	public var orders:List<String>;
	public var _grpStones:FlxTypedGroup<Rock>;
	private var _grpGold:FlxTypedGroup<Gold>;
	public var _grpGems:FlxTypedGroup<Gem>;
	public var _grpProjectile:FlxTypedGroup<Projectile>;
	override public function create():Void
	{
		_player = new FlxSprite(100, 100);
		_player.loadGraphic(AssetPaths.fireball__png, 16, 16);
		add(_player);
		_grpStones = new FlxTypedGroup<Rock>();
		_grpGold = new FlxTypedGroup<Gold>();
		_grpGems = new FlxTypedGroup<Gem>();
		_grpProjectile = new FlxTypedGroup<Projectile>();
		add(_grpStones);
		add(_grpGold);
		add(_grpGems);
		add(_grpProjectile);
		client = new Client();
		clientThread = Thread.create(getInfo);
		orders = new List<String>();
		super.create();
		
	}
	
	public function getInfo()
	{
		while (true)
		{
			var str:String = client.read();
			if(str.length>5)
				orders.add(str);
		}
	}
	override public function update():Void
	{
		
		while(!orders.isEmpty()) {
			//befehle vom server bestehen aus Strings von der Länge 8
			var item:String = orders.pop();
			
			//der 1. char gibt die Art des Befehls an, also entity erzeugen, verändern, löschen usw.
			 //die nächsten beiden chars geben die art der entity an, rock, player, bombe usw. 	
			 //danach kommen 4 chars, die eine identifikation der entity ermöglichen(unique ID)
			 //am ende dann 9 chars, die genaue werte beschreiben, was für werte hängt von der befehlsart und entityart ab 
			
			var order:String = item.substr(0, 1);
			var group:String = item.substr(1, 2);
			var id:String = item.substr(3, 4);
			var value:String = item.substr(7);
			trace("order: " + order +" group: " + group + " id: " + id + " value: " +value);
			switch(order) {
				//create entity
				case "1":
					switch(group) {
						//Rock
						case "x1":
							addRock(id, value);
						//Player
						case "x2":
							addPlayer(id, value);
						//Bomb
						case "x3":
							addBomb(id, value);
						//Coin
						case "x4":
							addCoin(id, value);
						//Gem
						case "x5":
							addGem(id, value);
					}
				//delete entity
				case "2":
					switch(group) {
						//Rock
						case "x1":
							deleteRock(id);
						//Player
						case "x2":
							deletePlayer(id);
						//Bomb
						case "x3":
							deleteBomb(id);
						//Coin
						case "x4":
							deleteCoin(id);
						//Gem
						case "x5":
							deleteGem(id);
					}
				case "3":
					//modify entity
					switch(group) {
						//Rock
						case "x1":
							modRock(id, value);
						//Player
						case "x2":
							modPlayer(id, value);
						//Bomb
						case "x3":
							modBomb(id, value);
						//Coin
						case "x4":
							modCoin(id, value);
						//Gem
						case "x5":
							modGem(id, value);
					}
					
			}
			
		}
		super.update();
	}
	public function	addRock(id:String, value:String)
	{
		switch(id.charAt(0)){
			case '1':
				_grpStones.add(new Stone(Std.parseFloat(value.substr(0,4)),Std.parseFloat(value.substr(5,4))));
		}
	}
	public function addPlayer(id, value)
	{
		
	}
	public function addBomb(id, value)
	{
		
	}
	public function addCoin(id, value)
	{
		
	}
	public function addGem(id, value)
	{
		
	}
	public function	deleteRock(id)
	{
		
	}
	public function deletePlayer(id)
	{
		
	}
	public function deleteBomb(id)
	{
		
	}
	public function deleteCoin(id)
	{
		
	}
	public function deleteGem(id)
	{
		
	}
	public function	modRock(id, value)
	{
		
	}
	public function modPlayer(id, value)
	{
		
	}
	public function modBomb(id, value)
	{
		
	}
	public function modCoin(id, value)
	{
		
	}
	public function modGem(id, value)
	{
		
	}
}