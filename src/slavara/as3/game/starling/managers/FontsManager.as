package slavara.as3.game.starling.managers {
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
	import starling.text.TextField;
	
	/**
	 * @author SlavaRa
	 */
	public class FontsManager {
		
		private static const _ENUM_2_BUNDLE:Dictionary = new Dictionary(false);
		
		public static function getBitmapFontTextFormat(fontName:BaseEnum, size:Number = NaN, color:uint = 16777215, align:String = "left"):BitmapFontTextFormat {
			CONFIG::debug
			{
				Assert.isFalse(instance.fontIsRegistered(fontName), ("You should register font: " + fontName.toString()));
			}
			
			return new BitmapFontTextFormat(instance.getFont(fontName), size, color, align);
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
			
			if(!hasBundle(ResBundleNameEnum.FONTS)) {
				return;
			}
			const bundle:BaseFontResBundle = BaseFontResBundle(getBundle(ResBundleNameEnum.FONTS));
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