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
	public var theNumber:Int = 0;
	public var state:PlayState;
	
	override function clientConnected(sock:Socket):ClientData
	{
		trace("client connected");
		var c:ClientData = new ClientData(sock, theNumber);
		theNumber = theNumber + 1;
		clients.add(c);
		for (o in state._grpStones)
		{
			var s:String = Std.string(o.y).substr(0, 4);
			var r:String = Std.string(o.x).substr(0, 4);
			while (r.length < 4)
				r = "0" + r;
			while (s.length < 4)
				s = "0" + s;
			
			
			var str:String = "1x1100" + r + "." + s + "\n";
			sendData(c.sock,str);
		}
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
			complete = (buf.get(cpos) == 46);
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
		trace(msg.content);
	}
	public function inform(str:String)
	{
		str = str + "\n";
		for (c in clients) {
			trace(str);
			sendData(c.sock, str);
		}
		
	}
	
	 
}