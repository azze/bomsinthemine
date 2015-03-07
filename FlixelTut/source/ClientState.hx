package ;

import flixel.FlxState;
import sys.net.UdpSocket;

/**
 * ...
 * @author ...
 */
class ClientState extends FlxState
{
	var _player:Player;
	var _sock:UdpSocket;
	
	override public function create():Void
	{
		_player = new Sid(100, 100, this);
		_sock = new UdpSocket();
		_sock.connect("localhost", 6767);
		super.create();
		
	}
	override public function update():Void
	{
		var x:Float = Std.parseFloat(_sock.input.readLine());
		_player.x = x;
	}
	
}