package slavara.as3.game.starling.managers {
	import arp.remote.registerARP;
	import feathers.text.BitmapFontTextFormat;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import resources.FontResBundle;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.enums.ResBundleNameEnum;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	/**
	 * @author SlavaRa
	 */
	public class FontsManager {
		
		private static const _ENUM_2_BUNDLE:Dictionary = new Dictionary(false);
		
		public static function getBitmapFontTextFormat(fontName:BaseEnum, size:Number = NaN, color:uint = 16777215, align:String = "left"):BitmapFontTextFormat {
			CONFIG::debug
			{
				Assert.isFalse(instance.isRegistered(fontName), ("You should register font: " + fontName.toString()));
			}
			
			return new BitmapFontTextFormat(instance.getByName(fontName), size, color, align);
		}
		
		private static var _instance:FontsManager;
		private static var _isInitialized:Boolean = true;
		
		public static function get instance():FontsManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new FontsManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public function FontsManager() {
			super();
			
			CONFIG::debug
			{
				if (_isInitialized) {
					throw new Error("Singleton, use FontsManager.instance");
				}
			}
			
			_isLoaded = false;
			_onLoadComplete = new Signal();
			registerARP();
		}
		
		public function setup(bundles:Vector.<IResBundle>):void {
			CONFIG::debug
			{
				Assert.isNull(bundles, "bundles");
			}
			
			if(Validate.isNull(_bundles)) {
				_bundles = bundles;
			} else if(Collection.isNotEmpty(bundles)) {
				_bundles = _bundles.concat(bundles);
				_isLoaded = false;
			}
		}
		
		public function loadBundles():void {
			CONFIG::debug
			{
				if (_onLoadComplete.numListeners === 0) {
					throw new Error("перед началом загрузки, необходимо подписаться на окончание загрузки, используйте ResourceManager.instance.onLoadComplete.add");
				}
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
		
		public function has(name:BaseEnum):Boolean {
			return _ENUM_2_BUNDLE[name] !== null;
		}
		
		public function unloadAll():void {
			if (!_isLoaded) {
				return;
			}
			
			for each (var item:IResBundle in _bundles) {
				item.unload();
			}
			Collection.clear(_bundles);
			
			_isLoaded = false;
		}
		
		public function isRegistered(name:BaseEnum):Boolean {
			CONFIG::debug
			{
				Assert.isNull(name, "name");
			}
			
			return Validate.isNotNull(TextField.getBitmapFont(name.toString()));
		}
		
		public function register(name:BaseEnum):void {
			CONFIG::debug
			{
				Assert.isNull(name, "name");
			}
			if(!has(ResBundleNameEnum.FONTS)) {
				return;
			}
			const bundle:FontResBundle = FontResBundle(_ENUM_2_BUNDLE[ResBundleNameEnum.FONTS]);
			if(Validate.isNull(bundle.has(ResBundleNameEnum.FONTS))){
				return;
			}
			TextField.registerBitmapFont(bundle.getBitmapFont(name), name.toString());
		}
		
		public function getByName(name:BaseEnum):BitmapFont {
			CONFIG::debug
			{
				Assert.isNull(name, "name");
			}
			
			return TextField.getBitmapFont(name.toString());
		}
		
		public function unregister(name:BaseEnum, dispose:Boolean = true):void {
			CONFIG::debug
			{
				Assert.isNull(name, "name");
			}
			
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