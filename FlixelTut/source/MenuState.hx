package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnJim:FlxButton;
	private var _btnSid:FlxButton;
	private var _btnTrevor:FlxButton;
	private var _sprJim:FlxSprite;
	private var _sprSid:FlxSprite;
	private var _sprTrevor:FlxSprite;
	public var gameMode:Float = 0;
	public var ip:String = "";
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var title:FlxText;
		title = new FlxText(0, 16, FlxG.width, "Select your Hero!");
		title.setFormat (null, 16, 0xFFFFFFFF, "center");
		add(title);
		_btnJim = new FlxButton(64, 128, "Jim", clickJim);
		add(_btnJim);
		_btnSid = new FlxButton(64, 192, "Sid", clickSid);
		add(_btnSid);
		_btnTrevor = new FlxButton(64, 256, "Trevor", clickTrevor);
		add(_btnTrevor);
		_sprJim = new FlxSprite(200, 100 , AssetPaths.Jim_Thumb_v1__png);
		add(_sprJim);
		_sprSid = new FlxSprite(200, 180 , AssetPaths.Sid_Thumb_v1__png);
		add(_sprSid);
		_sprTrevor = new FlxSprite(200, 260 , AssetPaths.Trevor_Thumb_v1__png);
		add(_sprTrevor);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_btnJim = FlxDestroyUtil.destroy(_btnJim);
		_btnSid = FlxDestroyUtil.destroy(_btnSid);
		_btnTrevor = FlxDestroyUtil.destroy(_btnTrevor);
	}
	
	private function clickJim():Void
	{
		startGame(gameMode, 0);
	}
	
	private function clickSid():Void
	{
		startGame(gameMode, 1);
	}
	
	private function clickTrevor():Void
	{
		startGame(gameMode, 2);
	}
	public function startGame(i:Float, j:Int):Void
	{
		if (i == 0) {
			var state:ClientState = new ClientState();
			state.ip = ip;
			state.setupIP();  
			state.playerClass = j;
			state.gameType = gameMode;
			FlxG.switchState(state);
		}
		else {
			var state:ServerState = new ServerState();
			state.playerClass = j;
			state.gameType = gameMode;
			FlxG.switchState(state);
		}
	}
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}