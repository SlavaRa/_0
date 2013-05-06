package slavara.as3.game.starling.resources {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.BaseEnum;
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public interface IResBundle {
		function load():void;
		function has(uri:BaseEnum):Boolean;
		function getClass(uri:BaseEnum):Class;
		function getDisplayObject(uri:BaseEnum):DisplayObject;
		function getBitmap(uri:BaseEnum):Bitmap;
		function getBitmapData(uri:BaseEnum):BitmapData;
		function getByteArray(uri:BaseEnum):ByteArray;
		function getTexture(uri:BaseEnum):Texture;
		function unload():void;
		
		function toString():String;
		
		function get name():BaseEnum;
		function get onLoadComplete():Signal;
		function get isLoaded():Boolean;
	}
}