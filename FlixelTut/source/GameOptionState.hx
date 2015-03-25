package ;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxDestroyUtil;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author ...
 */
class GameOptionState extends FlxState
{
	private var _btnClient:FlxButton;
	private var _btnServer:FlxButton;
	private var _btnSandbox:FlxButton;
	private var _inputHUD:InputHUD;
	private var _btnOK:FlxButton;

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
		_inputHUD = new InputHUD();
		_btnOK = new FlxButton(_inputHUD._sprBack.x + 115, _inputHUD._sprBack.y + 75, "OK", clickOK);
		_btnOK.screenCenter(true, false);
		_btnOK.x = _btnOK.x + (_inputHUD._sprBack.width / 4);
		add(_inputHUD);
		_inputHUD.add(_btnOK);
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
		
		_inputHUD.initiateInput();
		
	}
		private function clickOK():Void
	{
		
		var state:MenuState = new MenuState();
		state.gameMode = 0;
		state.ip = _inputHUD.getText();
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
		var state:ServerState = new ServerState();
		state.gameType = 2;
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