package ;
import haxe.remoting.AsyncProxy;
import haxe.remoting.Context;
import haxe.remoting.SocketConnection;
import sys.net.Socket;
import sys.net.Host;
/**
 * ...
 * @author ...
 */
class ServerApiImpl extends AsyncProxy<ServerApi> {
	
}

class Client implements ClientApi
{
	var api:ServerApiImpl;
	var name:String="jonny2000";
	var sock:Socket;
	var data:String;
	public function new() 
	{
		sock = new Socket();
		try{
			sock.connect(new Host("localhost"), 5000);
		}
		catch (msg:String) {
			trace(msg);
		}
		var context:Context = new Context();
		context.addObject("client", this);
		var scnx = SocketConnection.create(sock, context);
		api = new ServerApiImpl(scnx.api);
		data = "1";
		api.identify(name);
	}
	public function send( text : String ) {
		if( name == null ) {
			name = text;
			api.identify(name);
			return;
		}
		
	}
	public function inform(str:String)
	{
		trace(str);
		data = str;
	}
	public function read():String 
	{
		return "100";
	}
	
}