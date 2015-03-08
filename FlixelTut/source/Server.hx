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
	
	
	override function clientConnected(sock:Socket):ClientData
	{
		var c:ClientData = new ClientData(sock, theNumber);
		theNumber = theNumber + 1;
		clients.add(c);
		return c;
	}
	override function clientDisconnected(c:ClientData)
	{
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
			sendData(c.sock, str);
		}
		
	}
	
	 
}