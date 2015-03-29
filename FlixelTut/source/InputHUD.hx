package;

import flixel.addons.ui.FlxInputText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.text.TextField;
import openfl.text.TextFieldType;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author Phil
 */
class InputHUD extends FlxTypedGroup<FlxSprite>
{
	
	public var _sprBack:FlxSprite;
	private var _title:FlxText;
	private var _textInput:FlxInputText;
	public var _btnCncl:FlxButton;
	private var _alpha:Float = 0;

	public function new() 
	{
		super();
	
		_sprBack = new FlxSprite().makeGraphic(320, 100, FlxColor.WHITE);
		_sprBack.drawRect(1, 1 , 318, 98, FlxColor.CHARCOAL);
		
		_sprBack.screenCenter(true, true);
		add(_sprBack);
		
		_title = new FlxText(0,_sprBack.y + 5, FlxG.width, "Please Input IP");
		_title.setFormat(null, 12, 0xFFFFFFFF, "center");
		add(_title);
		
		_textInput = new FlxInputText(_sprBack.x + 10,_sprBack.y + _title.height + 20,150,"",8,FlxColor.BLACK,FlxColor.FOREST_GREEN);
		_textInput.setFormat(null, 8, 0xFFFFFFFF, "center");
		_textInput.screenCenter(true, false);
		//_textInput.border = true;
		//_textInput.borderSize = 2;
		//_textInput.borderColor = 0xFFFFFF;
		
		add(_textInput);
		
		_btnCncl = new FlxButton(_sprBack.x + 115, _sprBack.y + 75, "Cancel", clickCancel);
		_btnCncl.screenCenter(true, false);
		_btnCncl.x = _btnCncl.x - (_sprBack.width / 4);
		add(_btnCncl);
		
		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set();
			spr.alpha = 0;
		});
		
		active = false;
		visible = false;
	}
	
	private function clickCancel():Void
	{
		_textInput.visible = false;
		_btnCncl.visible = false;
		FlxTween.num(1, 0, .66, { ease:FlxEase.circOut, complete:finishFadeOut}, updateAlpha);
	}
	
	public function getText():String
	{
		
		return _textInput.text;
		
	}
	
	public function initiateInput():Void
	{
		_textInput.visible = true;
		_btnCncl.visible = true;
		visible = true;
		
		FlxTween.num(0, 1, .66, { ease:FlxEase.circOut, complete:finishFadeIn }, updateAlpha);
	}
	
	private function updateAlpha(Value:Float):Void
	{
		_alpha = Value;
		forEach(function(spr:FlxSprite) {
			spr.alpha = _alpha;
		});
	}
	
	private function finishFadeIn(_):Void
	{
		active = true;
	}
	
	private function finishFadeOut(_):Void
	{
		active = false;
		visible = false;
	}
	
}