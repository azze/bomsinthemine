package ;

import flixel.FlxSprite;
import flixel.FlxState;
import sys.net.Host;
import sys.net.UdpSocket;
import neko.vm.Thread;
import flixel.group.FlxTypedGroup;
import neko.Lib;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class ClientState extends PlayState
{
	
	var client:Client;
	var clientThread:Thread;
	var orders:List<String>;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _C:Bool = false;
	var _X:Bool = false;
	var _V:Bool = false;
	var _space:Bool = false;
	var msg:String;
	override public function create():Void
	{
		super.create();
		client = new Client();
		client.write(playerClass + "\n");
		
		clientThread = Thread.create(communicate);
		orders = new List<String>();
		
		
	}
	
	public function communicate()
	{
		while (true)
		{
			Thread.readMessage(true);
			var str:String = client.read();
			if(str.length>1)
				orders.add(str);
			client.write(msg);
			
		}
	}
	public function handleInput():Void
	{
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		_C = FlxG.keys.pressed.C;
		_X = FlxG.keys.justPressed.X;
		_V = FlxG.keys.pressed.V;
		_space = FlxG.keys.pressed.SPACE;
		msg = "";
		msg = appendBool(msg, _up);
		msg = appendBool(msg, _down);
		msg = appendBool(msg, _left);
		msg = appendBool(msg, _right);
		msg = appendBool(msg, _C);
		msg = appendBool(msg, _V);
		msg = appendBool(msg, _X);
		msg = appendBool(msg, _space);
		msg = msg + "!";
	}
	public function appendBool(msg:String, bl:Bool):String
	{
		if (bl)
			msg = msg + "1";
		else
			msg = msg +"0";
		return msg;
	}
	
	override public function update():Void
	{
		handleInput();
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
			switch(order) {
				//create entity
				case "1":
					switch(group) {
						//Rock
						case "x1":
							addCRock(id, value);
						//Player
						case "x2":
							addCPlayer(id, value);
						//Bomb
						case "x3":
							addCBomb(id, value);
						//Coin
						case "x4":
							addCCoin(id, value);
						//Gem
						case "x5":
							addCGem(id, value);
					}
				//delete entity
				case "2":
					switch(group) {
						//Rock
						case "x1":
							deleteCRock(id);
						//Player
						case "x2":
							deleteCPlayer(id);
						//Bomb
						case "x3":
							deleteCBomb(id);
						//Coin
						case "x4":
							deleteCCoin(id);
						//Gem
						case "x5":
							deleteCGem(id);
					}
				case "3":
					//modify entity
					switch(group) {
						//Rock
						case "x1":
							modCRock(id, value);
						//Player
						case "x2":
							modCPlayer(id, value);
						//Bomb
						case "x3":
							modCBomb(id, value);
						//Coin
						case "x4":
							modCCoin(id, value);
						//Gem
						case "x5":
							modCGem(id, value);
					}
					
			}
			
		}
		clientThread.sendMessage("hi");
		super.update();
	}
	public function	addCRock(id:String, value:String)
	{
		switch(id.charAt(0)){
			case '1':
				var stn:Stone = new Stone(Std.parseFloat(value.substr(0, 4)), Std.parseFloat(value.substr(5, 4)));
				stn.id = Std.parseInt(id.substr(1, 3));
				_grpStones.add(stn);
		}
	}
	public function addCPlayer(id, value)
	{
		switch(id.charAt(0)){
			case '1':
				var ply:Player = new Jim(Std.parseFloat(value.substr(0, 4)), Std.parseFloat(value.substr(5, 4)),this );
				ply.id=Std.parseInt(id.substr(1, 3));
				_grpPlayer.add(ply);
			case '2':
				var ply:Player = new Sid(Std.parseFloat(value.substr(0, 4)), Std.parseFloat(value.substr(5, 4)), this);
				ply.id=Std.parseInt(id.substr(1, 3));
				_grpPlayer.add(ply);
			case '3':
				var ply:Player = new Trevor(Std.parseFloat(value.substr(0, 4)), Std.parseFloat(value.substr(5, 4)), this);
				ply.id=Std.parseInt(id.substr(1, 3));
				_grpPlayer.add(ply);
			
		}
	}
	public function addCBomb(id, value)
	{
		
	}
	public function addCCoin(id, value)
	{
		switch(id.charAt(0)){
			case '0':
				var gld:Gold = new Gold(Std.parseFloat(value.substr(0, 4)), Std.parseFloat(value.substr(5, 4)));
				gld.id=Std.parseInt(id.substr(1, 3));
				_grpGold.add(gld);
		}
	}
	public function addCGem(id:String, value:String)
	{
		
	}
	public function	deleteCRock(id)
	{
		
	}
	public function deleteCPlayer(id)
	{
		
	}
	public function deleteCBomb(id)
	{
		
	}
	public function deleteCCoin(id)
	{
		
	}
	public function deleteCGem(id)
	{
		
	}
	public function	modCRock(id, value)
	{
		
	}
	public function modCPlayer(id:String, value:String)
	{
		switch(value.charAt(0)) {
			case 'p':
				var u = value.substr(1, 4);
				var v = value.substr(5, 4);
				if (u.charAt(3) == '.')
					u = u.substr(0, 3);
				if (v.charAt(3) == '.')
					v = v.substr(0, 3);
				while (u.charAt(0) == "0")
					u = u.substr(1);
				while (v.charAt(0) == "0")
					v = v.substr(1);
				var r = Std.parseFloat(u);
				var s = Std.parseFloat(v);
				var mem:Player = getMemberbyID(id.substr(1, 3));
				mem.x = r;
				mem.y = s;
		}
	}
	public function modCBomb(id, value)
	{
		
	}
	public function modCCoin(id, value)
	{
		
	}
	public function modCGem(id, value)
	{
		
	}
	public function getMemberbyID(str:String):Player 
	{
		if (str.charAt(0) == '0')
		{
			str = str.substr(1);
			if (str.charAt(0) == '0')
			{
				str = str.substr(1);
			}
		}
		var uid = Std.parseInt(str);
		for ( m in _grpPlayer) {
			if (m.id == uid)
				return m;
		}
		return null;
		
	}
}