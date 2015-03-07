package ;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxDestroyUtil;
/**
 * ...
 * @author ...
 */
class GameOptionState extends FlxState
{
	private var _btnClient:FlxButton;
	private var _btnServer:FlxButton;
	private var _btnSandbox:FlxButton;

	override public function create():Void
	{
		var title:FlxText;
		title = new FlxText(0, 16, FlxG.width, "Select Gamemode!");
		title.setFormat (null, 16, 0xFFFFFFFF, "center");
		add(title);
		_btnClient = new FlxButton(64, 128, "Join a game!", clickClient);
		add(_btnClient);
		_btnServer = new FlxButton(64, 192, "Host a game", clickServer);
		add(_btnServer);
		_btnSandbox = new FlxButton(64, 256, "Sandbox", clickSandbox);
		add(_btnSandbox);
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_btnClient = FlxDestroyUtil.destroy(_btnClient);
		_btnServer = FlxDestroyUtil.destroy(_btnServer);
		_btnSandbox = FlxDestroyUtil.destroy(_btnSandbox);
	}
	
	private function clickClient():Void
	{
		var state:MenuState = new MenuState();
		state.gameMode = 0;
		FlxG.switchState(state);
	}
	
	private function clickServer():Void
	{
		var state:MenuState = new MenuState();
		state.gameMode = 1;
		FlxG.switchState(state);
	}
	
	private function clickSandbox():Void
	{
		var state:MenuState = new MenuState();
		state.gameMode = 2;
		FlxG.switchState(state);
	}
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
}