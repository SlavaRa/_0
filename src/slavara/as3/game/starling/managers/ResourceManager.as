package slavara.as3.game.starling.managers {

	import arp.remote.registerARP;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.enums.ResBundleNameEnum;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public final class ResourceManager {
		
		private static const _ENUM_2_BUNDLE:Dictionary = new Dictionary(false);
		
		public static function getTextureFromARPBundle(texName:BaseEnum):Texture {
			const bundle:IResBundle = (_ENUM_2_BUNDLE[ResBundleNameEnum.ARP] as IResBundle);
			return bundle ? bundle.getTexture(texName) : null;
		}
		
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
		
		public function ResourceManager() {
			super();
			
			CONFIG::debug
			{
				if (_isInitialized) {
					throw new Error("Singleton, use ResourceManager.instance");
				}
			}
			
			_bundles = new <IResBundle>[];
			_onLoadComplete = new Signal();
			registerARP();
		}
		
		public function add(bundle:IResBundle):void {
			if(Validate.isNull(bundle)){
				return;
			}
			if(has(bundle.name)) {
				return;
			}
			_bundles.push(bundle);
		}
		
		public function loadBundles():void {
			CONFIG::debug
			{
				if (_onLoadComplete.numListeners === 0) {
					throw new Error("перед началом загрузки, необходимо подписаться на окончание загрузки, используйте ResourceManager.instance.onLoadComplete.add");
				}
			}
			
			if (Collection.isEmpty(_bundles)) {
				_onLoadComplete.dispatch();
				return;
			}
			
			for each (var item:IResBundle in _bundles) {
				if(item.isLoaded) {
					continue;
				}
				item.onLoadComplete.addOnce(onBundleLoadComplete);
				item.load();
			}
		}
		
		public function unloadAll():void {
			for (var name:* in _ENUM_2_BUNDLE) {
				IResBundle(_ENUM_2_BUNDLE).unload();
			}
			Collection.clear(_ENUM_2_BUNDLE);
			Collection.clear(_bundles);
		}
		
		public function has(name:BaseEnum):Boolean {
			return Boolean(_ENUM_2_BUNDLE[name]);
		}
		
		public function getByName(name:BaseEnum):IResBundle {
			if (!has(name)) {
				return null;
			}
			return IResBundle(_ENUM_2_BUNDLE[name]);
		}
		
		private var _bundles:Vector.<IResBundle>;
		private var _totalLoaded:int;
		private var _onLoadComplete:Signal;
		
		private function onBundleLoadComplete(bundle:IResBundle):void {
			_ENUM_2_BUNDLE[bundle.name] = bundle;
			_totalLoaded++;
			if (_totalLoaded === _bundles.length) {
				_onLoadComplete.dispatch();
				Collection.clear(_bundles);
			}
		}
		
		public function get onLoadComplete():Signal {
			return _onLoadComplete;
		}
		
	}
}