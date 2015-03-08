package ;

import flixel.FlxSprite;
import flixel.FlxState;
import sys.net.Host;
import sys.net.UdpSocket;
import neko.vm.Thread;

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
	var newInfo:Bool = false;
	var info:String;
	override public function create():Void
	{
		_player = new FlxSprite(100, 100);
		_player.loadGraphic(AssetPaths.fireball__png, 16, 16);
		add(_player);
		client = new Client();
		clientThread = Thread.create(getInfo);
		super.create();
		
	}
	
	public function getInfo()
	{
		while (true)
		{
			info = client.read();
			newInfo = true;
		}
	}
	override public function update():Void
	{
		if (newInfo) {
			var	x = Std.parseFloat(info);
			_player.x = x;
		}
		super.update();
	}
	
}