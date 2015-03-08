package ;
import sys.net.Host;
import sys.net.Socket;

/**
 * ...
 * @author ...
 */
class Server
{
	var sock:Socket;

	public function new() 
	{
		sock = new Socket();
		sock.bind(new Host("localhost"), 5000);
		
	}
	public function write(str:String = "")
	{
		sock.listen(1);
		var c:Socket = sock.accept();
		trace("this actually happens!");
		c.write(str);
	}
	
}