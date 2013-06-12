package slavara.as3.game.starling.gui.builders {
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.DestroyUtils;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * @author SlavaRa
	 */
	public class GUIBuilder implements IGUIBuilder, IDestroyable {
		
		public function GUIBuilder(config:GUIConfig) {
			CONFIG::debug
			{
				Assert.isNull(config, "config");
			}
			
			super();
			initialize(config);
		}
		
		/* INTERFACE slavara.as3.game.starling.gui.builders.IGUIBuilder */
		public function build():void {
			_onBuild.dispatch();
		}
		
		/* INTERFACE slavara.as3.game.starling.gui.builders.IGUIBuilder */
		public function getProduct():DisplayObjectContainer {
			return product;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function destroy():void {
			DestroyUtils.destroy(_onBuild);
			DestroyUtils.destroy(product);
			_onBuild = null;
			product = null;
			config = null;
			_isDestroyed = true;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		protected var config:GUIConfig;
		protected var product:DisplayObjectContainer;
		
		protected function initialize(config:GUIConfig):void {
			_isDestroyed = false;
			this.config = config;
			_onBuild = new Signal();
		}
		
		/**
		 * create some item
		 */
		protected function preBuildItem(config:GUIConfig):DisplayObject {
			return Validate.isNotNull(config) ? new Sprite() : null;
		}
		
		/**
		 * setups name, alpha, filter, rotation, scaleX, scaleY, x, y
		 */
		protected function postBuildItem(item:DisplayObject, config:GUIConfig):DisplayObject {
			item.name = config.name;
			item.alpha = config.alpha;
			item.filter = config.filter;
			item.rotation = config.rotation;
			StarlingDisplayUtils.setxy(item, config.x, config.y);
			StarlingDisplayUtils.setsize(item, config.width, config.height);
			StarlingDisplayUtils.setscale(item, config.scaleX, config.scaleY);
			return item;
		}
		
		public function fillContainer(container:DisplayObjectContainer, configs:Vector.<GUIConfig>):void {
			if (Validate.isNull(container)) {
				return;
			}
			if (container is TextField) {
				return;
			}
			if (Collection.isEmpty(configs)) {
				return;
			}
			for each (var config:GUIConfig in configs) {
				const item:DisplayObject = preBuildItem(config);
				fillContainer(item as DisplayObjectContainer, config.children);
				StarlingDisplayUtils.addChildTo(item, container);
			}
		}
		
		private var _isDestroyed:Boolean;
		private var _onBuild:Signal;
		
		public function get onBuild():Signal {
			return _onBuild;
		}
		
	}
}