package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/Game.oep", "assets/data/Game.oep");
			type.set ("assets/data/Game.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/minelvl002.oel", "assets/data/minelvl002.oel");
			type.set ("assets/data/minelvl002.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/minelvl003.oel", "assets/data/minelvl003.oel");
			type.set ("assets/data/minelvl003.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/room-001.oel", "assets/data/room-001.oel");
			type.set ("assets/data/room-001.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/BigBomb.png", "assets/images/BigBomb.png");
			type.set ("assets/images/BigBomb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Bomb.png", "assets/images/Bomb.png");
			type.set ("assets/images/Bomb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fireball.png", "assets/images/fireball.png");
			type.set ("assets/images/fireball.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fireball2.png", "assets/images/fireball2.png");
			type.set ("assets/images/fireball2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fireballa.png", "assets/images/fireballa.png");
			type.set ("assets/images/fireballa.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fireballfull.png", "assets/images/fireballfull.png");
			type.set ("assets/images/fireballfull.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Game_Template_Miner_Sid.png", "assets/images/Game_Template_Miner_Sid.png");
			type.set ("assets/images/Game_Template_Miner_Sid.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Game_Template_Miner_Trevor.png", "assets/images/Game_Template_Miner_Trevor.png");
			type.set ("assets/images/Game_Template_Miner_Trevor.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Game_Template_Miner_v1.png", "assets/images/Game_Template_Miner_v1.png");
			type.set ("assets/images/Game_Template_Miner_v1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Game_Template_Miner_v2.png", "assets/images/Game_Template_Miner_v2.png");
			type.set ("assets/images/Game_Template_Miner_v2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Game_Template_Tiles_v1.png", "assets/images/Game_Template_Tiles_v1.png");
			type.set ("assets/images/Game_Template_Tiles_v1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/gem.png", "assets/images/gem.png");
			type.set ("assets/images/gem.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/gold.png", "assets/images/gold.png");
			type.set ("assets/images/gold.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/health.png", "assets/images/health.png");
			type.set ("assets/images/health.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/iron.png", "assets/images/iron.png");
			type.set ("assets/images/iron.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/iron2.png", "assets/images/iron2.png");
			type.set ("assets/images/iron2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Jim_Thumb_v1.png", "assets/images/Jim_Thumb_v1.png");
			type.set ("assets/images/Jim_Thumb_v1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Sid_Thumb_v1.png", "assets/images/Sid_Thumb_v1.png");
			type.set ("assets/images/Sid_Thumb_v1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/stone.png", "assets/images/stone.png");
			type.set ("assets/images/stone.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Trevor_Thumb_v1.png", "assets/images/Trevor_Thumb_v1.png");
			type.set ("assets/images/Trevor_Thumb_v1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/Explosion.wav", "assets/sounds/Explosion.wav");
			type.set ("assets/sounds/Explosion.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/Hit_Hurt2.wav", "assets/sounds/Hit_Hurt2.wav");
			type.set ("assets/sounds/Hit_Hurt2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/Jump3.wav", "assets/sounds/Jump3.wav");
			type.set ("assets/sounds/Jump3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/Laser_Shoot14.wav", "assets/sounds/Laser_Shoot14.wav");
			type.set ("assets/sounds/Laser_Shoot14.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/Pickup_Coin.wav", "assets/sounds/Pickup_Coin.wav");
			type.set ("assets/sounds/Pickup_Coin.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/walk.wav", "assets/sounds/walk.wav");
			type.set ("assets/sounds/walk.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
