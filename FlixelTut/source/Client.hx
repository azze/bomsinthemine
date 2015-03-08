package ;
import sys.net.Socket;
import sys.net.Host;
/**
 * ...
 * @author ...
 */
class Client
{
	var sock:Socket;

	public function new() 
	{
		sock = new Socket();
		sock.connect(new Host("localhost"), 5000);
		
	}
	public function read():String
	{
		var str:String = sock.input.readLine();
		trace(str);
		return str;
	}
	
}