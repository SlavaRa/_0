package slavara.as3.game.starling.managers {

	import arp.remote.registerARP;
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
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public final class ResourceManager {
		
		private static const _NAME_BUNDLE_2_BUNDLE:Dictionary = new Dictionary(false);
		
		private static var _instance:ResourceManager;
		private static var _isInitialized:Boolean = true;
		
		public static function get instance():ResourceManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new ResourceManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public static function getTextureFromARPBundle(texName:BaseEnum):Texture {
			const bundle:IResBundle = (_NAME_BUNDLE_2_BUNDLE[ResBundleNameEnum.ARP] as IResBundle);
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
			} else {
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
			return Boolean(_NAME_BUNDLE_2_BUNDLE[name]);
		}
		
		public function getBundle(name:BaseEnum):IResBundle {
			if (!hasBundle(name)) {
				return null;
			}
			return IResBundle(_NAME_BUNDLE_2_BUNDLE[name]);
		}
		
		public function fontIsRegistered(fontName:BaseEnum):Boolean {
			Assert.isNull(fontName, "fontName");
			return Validate.isNotNull(TextField.getBitmapFont(fontName.toString()));
		}
		
		public function registerFont(bundleName:BaseEnum, fontName:BaseEnum):void {
			Assert.isNull(bundleName, "bundleName");
			Assert.isNull(fontName, "fontName");
			if(!hasBundle(bundleName)) {
				return;
			}
			const bundle:FontResBundle = FontResBundle(getBundle(bundleName));
			if(Validate.isNull(bundle.has(bundleName))){
				return;
			}
			TextField.registerBitmapFont(bundle.getBitmapFont(fontName), fontName.toString());
		}
		
		public function getFont(fontName:BaseEnum):BitmapFont {
			Assert.isNull(fontName, "fontName");
			return TextField.getBitmapFont(fontName.toString());
		}
		
		public function unregisterFont(fontName:BaseEnum, dispose:Boolean = true):void {
			Assert.isNull(fontName, "fontName");
			TextField.unregisterBitmapFont(fontName.toString(), dispose);
		}
		
		private var _bundles:Vector.<IResBundle>;
		private var _totalLoaded:int;
		private var _isLoaded:Boolean;
		private var _onLoadComplete:Signal;
		
		private function onBundleLoadComplete(bundle:IResBundle):void {
			_NAME_BUNDLE_2_BUNDLE[bundle.name] = bundle;
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