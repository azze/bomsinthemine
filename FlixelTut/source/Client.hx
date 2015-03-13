package ;
import haxe.remoting.AsyncProxy;
import haxe.remoting.Context;
import haxe.remoting.SyncSocketConnection;
import sys.net.Socket;
import sys.net.Host;
/**
 * ...
 * @author ...
 */


class Client 
{
	
	var sock:Socket;
	var data:String;
	public function new() 
	{
		sock = new Socket();
		try{
			sock.connect(new Host("91.65.71.72"), 5000);
			trace("connected to server");
		}
		catch (msg:String) {
			trace("connection failed");
			trace(msg);
		}
	}
	
	public function read():String
	{
		data = sock.input.readLine();
		
		return data;
	}
	public function write(str:String):Void 
	{
		sock.write(str);
	}
	
}