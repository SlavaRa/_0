package slavara.as3.game.starling.managers {

	import arp.remote.registerARP;
	import feathers.text.BitmapFontTextFormat;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.enums.ResBundleNameEnum;
	import slavara.as3.game.starling.resources.BaseFontResBundle;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public final class ResourceManager {
		
		private static const _ENUM_2_BUNDLE:Dictionary = new Dictionary(false);
		
		private static var _instance:ResourceManager;
		private static var _isInitialized:Boolean = true;
		
		public static function getBitmapFontTextFormat(fontName:BaseEnum, size:Number = NaN, color:uint = 16777215, align:String = "left"):BitmapFontTextFormat {
			Assert.isFalse(instance.fontIsRegistered(fontName), ("You should register font: " + fontName.toString()));
			return new BitmapFontTextFormat(instance.getFont(fontName), size, color, align);
		}
		
		public static function get instance():ResourceManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new ResourceManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public static function getTextureFromARPBundle(texName:BaseEnum):Texture {
			const bundle:IResBundle = (_ENUM_2_BUNDLE[ResBundleNameEnum.ARP] as IResBundle);
			return bundle ? bundle.getTexture(texName) : null;
		}
		
		public function ResourceManager() {
			super();
			if (_isInitialized) {
				throw new Error("Singleton, use ResourceManager.instance");
			}
			_isLoaded = false;
			_onLoadComplete = new Signal();
			registerARP();
		}
		
		public function setup(bundles:Vector.<IResBundle>):void {
			Assert.isNull(bundles, "bundles");
			if(Validate.isNull(_bundles)) {
				_bundles = bundles;
			} else if(Collection.isNotEmpty(bundles)) {
				_bundles = _bundles.concat(bundles);
				_isLoaded = false;
			}
		}
		
		public function loadBundles():void {
			if (_onLoadComplete.numListeners === 0) {
				throw new Error("перед началом загрузки, необходимо подписаться на окончание загрузки, используйте ResourceManager.instance.onLoadComplete.add");
			}
			
			if (!_isLoaded && Collection.isNotEmpty(_bundles)) {
				for each (var item:IResBundle in _bundles) {
					if(item.isLoaded) {
						continue;
					}
					item.onLoadComplete.addOnce(onBundleLoadComplete);
					item.load();
				}
			} else {
				_onLoadComplete.dispatch();
			}
		}
		
		public function unloadBundles():void {
			if (!_isLoaded) {
				return;
			}
			
			for each (var item:IResBundle in _bundles) {
				item.unload();
			}
			
			_isLoaded = false;
		}
		
		public function hasBundle(name:BaseEnum):Boolean {
			return Boolean(_ENUM_2_BUNDLE[name]);
		}
		
		public function getBundle(name:BaseEnum):IResBundle {
			if (!hasBundle(name)) {
				return null;
			}
			return IResBundle(_ENUM_2_BUNDLE[name]);
		}
		
		public function fontIsRegistered(name:BaseEnum):Boolean {
			Assert.isNull(name, "name");
			return Validate.isNotNull(TextField.getBitmapFont(name.toString()));
		}
		
		public function registerFont(name:BaseEnum):void {
			Assert.isNull(name, "name");
			if(!hasBundle(ResBundleNameEnum.FONTS)) {
				return;
			}
			const bundle:BaseFontResBundle = BaseFontResBundle(getBundle(ResBundleNameEnum.FONTS));
			if(Validate.isNull(bundle.has(ResBundleNameEnum.FONTS))){
				return;
			}
			TextField.registerBitmapFont(bundle.getBitmapFont(name), name.toString());
		}
		
		public function getFont(name:BaseEnum):BitmapFont {
			Assert.isNull(name, "name");
			return TextField.getBitmapFont(name.toString());
		}
		
		public function unregisterFont(name:BaseEnum, dispose:Boolean = true):void {
			Assert.isNull(name, "name");
			TextField.unregisterBitmapFont(name.toString(), dispose);
		}
		
		private var _bundles:Vector.<IResBundle>;
		private var _totalLoaded:int;
		private var _isLoaded:Boolean;
		private var _onLoadComplete:Signal;
		
		private function onBundleLoadComplete(bundle:IResBundle):void {
			_ENUM_2_BUNDLE[bundle.name] = bundle;
			_totalLoaded++;
			if (_totalLoaded === _bundles.length) {
				_isLoaded = true;
				_onLoadComplete.dispatch();
			}
		}
		
		public function get onLoadComplete():Signal {
			return _onLoadComplete;
		}
		
	}
}