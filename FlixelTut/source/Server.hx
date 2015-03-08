package ;
import haxe.remoting.AsyncProxy;
import haxe.remoting.Context;
import haxe.remoting.SocketConnection;
import neko.net.ThreadRemotingServer;
import sys.net.Host;
import sys.net.Socket;
import neko.vm.Thread;

/**
 * ...
 * @author ...
 */
class ClientApiImpl extends AsyncProxy<ClientApi>
{
}

class ClientData implements ServerApi
{
	public var api:ClientApiImpl;
	public var name:String;
	public function  new (scnx:SocketConnection)
	{
		api = new ClientApiImpl(scnx.client	);
		(cast scnx).__private = this;
	}
	public function identify(name:String)
	{
		this.name = name;
		trace("this is important");
		Server.clients.add(this);
	}
	public function write(str:String)
	{
		
	}
	public function disconnect()
	{
		Server.clients.remove(this);
	}
	public static function ofConnection(scnx:SocketConnection):ClientData
	{
		return (cast scnx).__private;
	}
}
 
class Server
{
	public static var clients:List<ClientData> = new List<ClientData>();		
	public var s:ThreadRemotingServer;
	public function new() 
	{
		s = new ThreadRemotingServer(["localhost"]);
		s.initClientApi = initClientApi;
		s.clientDisconnected = onClientDisconnected;
		var tread:Thread = Thread.create(run);
	}
	
	public function run() 
	{
		trace("starting server");
		s.run("localhost", 5000);
	}
	public function write(str:String)
	{
		
		for ( c in clients)
		{
			trace(str);
			c.api.inform(str);
		}
	}
	static function initClientApi(scnx:SocketConnection, context:Context)
	{
		var c = new ClientData(scnx);
		context.addObject("api",c);
	}
	static function onClientDisconnected(scnx:SocketConnection) {
		ClientData.ofConnection(scnx).disconnect();
	}
	
}