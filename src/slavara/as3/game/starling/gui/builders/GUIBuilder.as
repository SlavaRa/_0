package slavara.as3.game.starling.gui.builders {
	import org.osflash.signals.Signal;
	import slavara.as3.core.utils.Assert;
	import slavara.as3.core.utils.DestroyUtils;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public class GUIBuilder implements IGUIBuilder, IDestroyable {
		
		public function GUIBuilder(config:GUIConfig) {
			Assert.isNull(config, "config");
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
		}
		
		protected var config:GUIConfig;
		protected var product:DisplayObjectContainer;
		
		protected function initialize(config:GUIConfig):void {
			this.config = config;
			_onBuild = new Signal();
		}
		
		/**
		 * create some item
		 */
		protected function preBuildItem(config:GUIConfig):DisplayObject {
			return null;
		}
		
		/**
		 * setups name, alpha, filter, rotation, scaleX, scaleY, x, y
		 */
		protected function postBuildItem(config:GUIConfig):DisplayObject {
			product.name = config.name;
			product.alpha = config.alpha;
			product.filter = config.filter;
			product.rotation = config.rotation;
			StarlingDisplayUtils.setxy(product, config.x, config.y);
			StarlingDisplayUtils.setscale(product, config.scaleX, config.scaleY);
			return product;
		}
		
		private var _onBuild:Signal;
		
		public function get onBuild():Signal {
			return _onBuild;
		}
		
	}
}