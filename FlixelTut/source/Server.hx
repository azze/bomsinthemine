package ;
import haxe.io.Bytes;
import haxe.remoting.AsyncProxy;
import haxe.remoting.Context;
import haxe.remoting.SyncSocketConnection;
import neko.net.ThreadServer;
import sys.net.Host;
import sys.net.Socket;
import neko.vm.Thread;

/**
 * ...
 * @author ...
 */


class ClientData 
{
	public var sock:Socket;
	public var id:Int;
	public function  new (sock:Socket, id:Int)
	{
		this.sock = sock;
		this.id = id;
	}
	
}
class Message
{
	public var content:String;
	public var author:Int;
	public function new(cont:String, id:Int) {
		content = cont;
		author = id;
	}
}
 
class Server extends ThreadServer<ClientData, Message>
{
	public static var clients:List<ClientData> = new List<ClientData>();		
	public var theNumber:Int = 1;
	public var state:ServerState;
	
	override function clientConnected(sock:Socket):ClientData
	{
		trace("client connected");
		var c:ClientData = new ClientData(sock, theNumber);
		theNumber = theNumber + 1;
		clients.add(c);
		var str:String = "";
		for (o in state._grpStones)
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
			 str =str+ "1x1"+o.type+ uid + r + "." + s + "\n";
			
		}
		for (o in state._grpGold)
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
			str =str+ "1x4"+o.type+ uid + r + "." + s + "\n";
			
		}
		
		var plType:String = c.sock.input.readLine();
		trace(plType);
		switch(plType.charAt(0))
		{
			case '0':
				state.addPlayer(new Jim(0,0,state));
			case '1':
				state.addPlayer(new Sid(0,0,state));
			case '2':
				state.addPlayer(new Trevor(0,0,state));
		}
		for (o in state._grpPlayer)
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
			str =str+ "1x2"+o.type+ uid + r + "." + s + "\n";
			
		}
		sendData(c.sock,str);
		return c;
	}
	override function clientDisconnected(c:ClientData)
	{
		trace("client disconnected");
		clients.remove(c);
	}
	override function readClientMessage(c:ClientData, buf:Bytes, pos:Int, len:Int)
	{
		var complete = false;
		var cpos = pos;
		while (cpos < (pos+len) && !complete)
		{
			//check for a period/full stop (i.e.:  "." ) to signify a complete message 
			complete = (buf.get(cpos) == 33);
			cpos++;
		}

		// no full message
		if( !complete ) return null;

		// got a full message, return it
		var msg:String = buf.getString(pos, cpos - pos);
		var meg:Message =new Message(msg, c.id);
		return {msg: meg  , bytes: cpos - pos };
	}
	override function clientMessage( c : ClientData, msg : Message )
	{
		var arr:Array<String> = msg.content.split("\n");
		var playa:Player = state._grpPlayer.members[c.id];
		var bl:Bool;
		for (str in arr) {
			if (str.charAt(1) == "1")
				bl = true;
			else
				bl = false;
			switch(str.charAt(0)) {
				case "u":
					playa._up = bl;
				case "d":
					playa._down = bl;
				case "l":
					playa._left = bl;
				case "r":
					playa._right = bl;
				case "v":
					playa._V = bl;
				case "c":
					playa._C = bl;
				case "x":
					playa._X = bl;
				case "q":
					playa._space = bl;
					
			}
		}
		state.sendCoordinates(playa);
	}
	public function inform(str:String)
	{
		str = str + "\n";
		for (c in clients) {
			sendData(c.sock, str);
		}
		
	}
	
	 
}