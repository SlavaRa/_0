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
		
		public function build():void { _onBuild.dispatch(); }
		
		public function getProduct():DisplayObjectContainer { return product; }
		
		public function destroy():void {
			_onBuild = DestroyUtils.destroy(_onBuild);
			product = DestroyUtils.destroy(product);
			config = null;
			_isDestroyed = true;
		}
		
		public function get isDestroyed():Boolean { return _isDestroyed; }
		
		protected var config:GUIConfig;
		protected var product:DisplayObjectContainer;
		
		protected function initialize(config:GUIConfig):void {
			_isDestroyed = false;
			this.config = config;
			_onBuild = new Signal();
		}
		
		protected function preBuildItem(config:GUIConfig):DisplayObject { return Validate.isNotNull(config) ? new Sprite() : null; }
		
		protected function postBuildItem(item:DisplayObject, config:GUIConfig):DisplayObject {
			item.name = config.name;
			item.alpha = config.alpha;
			item.skewX = config.skewX;
			item.skewY = config.skewY;
			item.filter = config.filter;
			item.visible = config.visible;
			item.touchable = config.touchable;
			item.useHandCursor = config.useHandCursor;
			StarlingDisplayUtils.setxy(item, config.x, config.y);
			StarlingDisplayUtils.setsize(item, config.width, config.height);
			StarlingDisplayUtils.scale(item, config.scaleX, config.scaleY);
			return item;
		}
		
		public function fill(container:DisplayObjectContainer, configs:Vector.<GUIConfig>):void {
			if (Validate.isNull(container) || (container is TextField) || Collection.isEmpty(configs)) {
				return;
			}
			for each (var config:GUIConfig in configs) {
				const item:DisplayObject = preBuildItem(config);
				fill(item as DisplayObjectContainer, config.children);
				StarlingDisplayUtils.addChildTo(item, container);
			}
		}
		
		private var _isDestroyed:Boolean;
		private var _onBuild:Signal;
		
		public function get onBuild():Signal { return _onBuild; }
		
	}
}