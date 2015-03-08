package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl._v2.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		path.set ("assets/data/Game.oep", "assets/data/Game.oep");
		type.set ("assets/data/Game.oep", AssetType.TEXT);
		path.set ("assets/data/minelvl002.oel", "assets/data/minelvl002.oel");
		type.set ("assets/data/minelvl002.oel", AssetType.TEXT);
		path.set ("assets/data/minelvl003.oel", "assets/data/minelvl003.oel");
		type.set ("assets/data/minelvl003.oel", AssetType.TEXT);
		path.set ("assets/data/room-001.oel", "assets/data/room-001.oel");
		type.set ("assets/data/room-001.oel", AssetType.TEXT);
		path.set ("assets/images/BigBomb.png", "assets/images/BigBomb.png");
		type.set ("assets/images/BigBomb.png", AssetType.IMAGE);
		path.set ("assets/images/Bomb.png", "assets/images/Bomb.png");
		type.set ("assets/images/Bomb.png", AssetType.IMAGE);
		path.set ("assets/images/fireball.png", "assets/images/fireball.png");
		type.set ("assets/images/fireball.png", AssetType.IMAGE);
		path.set ("assets/images/fireball2.png", "assets/images/fireball2.png");
		type.set ("assets/images/fireball2.png", AssetType.IMAGE);
		path.set ("assets/images/fireballa.png", "assets/images/fireballa.png");
		type.set ("assets/images/fireballa.png", AssetType.IMAGE);
		path.set ("assets/images/fireballfull.png", "assets/images/fireballfull.png");
		type.set ("assets/images/fireballfull.png", AssetType.IMAGE);
		path.set ("assets/images/Game_Template_Miner_Sid.png", "assets/images/Game_Template_Miner_Sid.png");
		type.set ("assets/images/Game_Template_Miner_Sid.png", AssetType.IMAGE);
		path.set ("assets/images/Game_Template_Miner_Trevor.png", "assets/images/Game_Template_Miner_Trevor.png");
		type.set ("assets/images/Game_Template_Miner_Trevor.png", AssetType.IMAGE);
		path.set ("assets/images/Game_Template_Miner_v1.png", "assets/images/Game_Template_Miner_v1.png");
		type.set ("assets/images/Game_Template_Miner_v1.png", AssetType.IMAGE);
		path.set ("assets/images/Game_Template_Miner_v2.png", "assets/images/Game_Template_Miner_v2.png");
		type.set ("assets/images/Game_Template_Miner_v2.png", AssetType.IMAGE);
		path.set ("assets/images/Game_Template_Tiles_v1.png", "assets/images/Game_Template_Tiles_v1.png");
		type.set ("assets/images/Game_Template_Tiles_v1.png", AssetType.IMAGE);
		path.set ("assets/images/gem.png", "assets/images/gem.png");
		type.set ("assets/images/gem.png", AssetType.IMAGE);
		path.set ("assets/images/gold.png", "assets/images/gold.png");
		type.set ("assets/images/gold.png", AssetType.IMAGE);
		path.set ("assets/images/health.png", "assets/images/health.png");
		type.set ("assets/images/health.png", AssetType.IMAGE);
		path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		path.set ("assets/images/iron.png", "assets/images/iron.png");
		type.set ("assets/images/iron.png", AssetType.IMAGE);
		path.set ("assets/images/iron2.png", "assets/images/iron2.png");
		type.set ("assets/images/iron2.png", AssetType.IMAGE);
		path.set ("assets/images/Jim_Thumb_v1.png", "assets/images/Jim_Thumb_v1.png");
		type.set ("assets/images/Jim_Thumb_v1.png", AssetType.IMAGE);
		path.set ("assets/images/Sid_Thumb_v1.png", "assets/images/Sid_Thumb_v1.png");
		type.set ("assets/images/Sid_Thumb_v1.png", AssetType.IMAGE);
		path.set ("assets/images/stone.png", "assets/images/stone.png");
		type.set ("assets/images/stone.png", AssetType.IMAGE);
		path.set ("assets/images/Trevor_Thumb_v1.png", "assets/images/Trevor_Thumb_v1.png");
		type.set ("assets/images/Trevor_Thumb_v1.png", AssetType.IMAGE);
		path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		path.set ("assets/sounds/drop.wav", "assets/sounds/drop.wav");
		type.set ("assets/sounds/drop.wav", AssetType.SOUND);
		path.set ("assets/sounds/Explosion.wav", "assets/sounds/Explosion.wav");
		type.set ("assets/sounds/Explosion.wav", AssetType.SOUND);
		path.set ("assets/sounds/Hit_Hurt2.wav", "assets/sounds/Hit_Hurt2.wav");
		type.set ("assets/sounds/Hit_Hurt2.wav", AssetType.SOUND);
		path.set ("assets/sounds/Jump3.wav", "assets/sounds/Jump3.wav");
		type.set ("assets/sounds/Jump3.wav", AssetType.SOUND);
		path.set ("assets/sounds/Laser_Shoot14.wav", "assets/sounds/Laser_Shoot14.wav");
		type.set ("assets/sounds/Laser_Shoot14.wav", AssetType.SOUND);
		path.set ("assets/sounds/Pickup_Coin.wav", "assets/sounds/Pickup_Coin.wav");
		type.set ("assets/sounds/Pickup_Coin.wav", AssetType.SOUND);
		path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		path.set ("assets/sounds/walk.wav", "assets/sounds/walk.wav");
		type.set ("assets/sounds/walk.wav", AssetType.SOUND);
		path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
		type.set ("assets/sounds/beep.ogg", AssetType.SOUND);
		path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
		type.set ("assets/sounds/flixel.ogg", AssetType.SOUND);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/Game.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/minelvl002.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/minelvl003.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/room-001.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/BigBomb.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Bomb.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireball.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireball2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireballa.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireballfull.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Game_Template_Miner_Sid.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Game_Template_Miner_Trevor.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Game_Template_Miner_v1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Game_Template_Miner_v2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Game_Template_Tiles_v1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/gem.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/gold.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/health.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/iron.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/iron2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Jim_Thumb_v1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Sid_Thumb_v1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/stone.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Trevor_Thumb_v1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/drop.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Explosion.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit_Hurt2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Jump3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser_Shoot14.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Pickup_Coin.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/walk.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/beep.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/flixel.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null || (assetType == BINARY && type == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash








































#elseif html5








































#else

#if (windows || mac || linux)







#else




#end

#end
