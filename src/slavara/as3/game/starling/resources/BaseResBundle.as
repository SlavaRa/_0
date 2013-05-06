package slavara.as3.game.starling.resources {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public class BaseResBundle implements IResBundle {
		
		protected static const NAME_2_RESOURCE:Dictionary = new Dictionary(false);
		private static const _BITMAP_DATAS_HASH:Object = new Dictionary(false);
		
		public function BaseResBundle(name:BaseEnum, assetsHash:Dictionary) {
			Assert.isNull(name, "name");
			Assert.isNull(assetsHash, "assetsHash");
			super();
			_isLoaded = false;
			_onLoadComplete = new Signal(BaseResBundle);
			_name = name;
			this.assetsHash = assetsHash;
		}
		
		/* INTERFACE manager.IResourceBundle */
		public function load():void {
			if (_onLoadComplete.numListeners === 0) {
				throw new Error("перед началом загрузки, необходимо подписаться на окончание загрузки, используйте ResourceManager.instance.onLoadComplete.add");
			}
			
			if (!isLoaded) {
				for (var name:* in assetsHash) {
					NAME_2_RESOURCE[name] = Class(assetsHash[name]);
				}
				_isLoaded = true;
			}
			onLoaded();
		}
		
		public function has(uri:BaseEnum):Boolean {
			return Boolean(NAME_2_RESOURCE[uri]);
		}
		
		public function getClass(uri:BaseEnum):Class {
			return has(uri) ? Class(new NAME_2_RESOURCE[uri]()) : null;
		}
		
		public function getDisplayObject(uri:BaseEnum):DisplayObject {
			return has(uri) ? DisplayObject(new NAME_2_RESOURCE[uri]()) : null;
		}
		
		public function getByteArray(uri:BaseEnum):ByteArray {
			return has(uri) ? ByteArray(new NAME_2_RESOURCE[uri]()) : null;
		}
		
		public function getBitmap(uri:BaseEnum):Bitmap {
			if (!has(uri)) {
				return null;
			}
			
			if (Boolean(_BITMAP_DATAS_HASH[uri])) {
				return new Bitmap(BitmapData(_BITMAP_DATAS_HASH[uri]));
			}
			
			const bitmap:Bitmap = Bitmap(new NAME_2_RESOURCE[uri]())
			_BITMAP_DATAS_HASH[uri] = bitmap.bitmapData;
			
			return bitmap;
		}
		
		public function getBitmapData(uri:BaseEnum):BitmapData {
			if (Boolean(_BITMAP_DATAS_HASH[uri])) {
				return BitmapData(_BITMAP_DATAS_HASH[uri]);
			} else if (!has(uri)) {
				return null;
			}
			
			return getBitmap(uri).bitmapData;
		}
		
		public function getTexture(uri:BaseEnum):Texture {
			//XXX: throw error
			return null;
		}
		
		public function unload():void {
			if (!isLoaded) {
				return;
			}
			
			for (var name:* in NAME_2_RESOURCE) {
				delete NAME_2_RESOURCE[name];
			}
			
			_isLoaded = false;
		}
		
		public function get name():BaseEnum {
			return _name;
		}
		
		public function get onLoadComplete():Signal {
			return _onLoadComplete;
		}
		
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
		
		public function toString():String {
			return "[BaseResBundle name=" + name + " isLoaded=" + isLoaded + "]";
		}
		
		protected var assetsHash:Dictionary;
		protected var _isLoaded:Boolean;
		
		protected function onLoaded():void {
			_onLoadComplete.dispatch(this);
		}
		
		private var _name:BaseEnum;
		private var _onLoadComplete:Signal;
		
	}
}