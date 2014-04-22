package slavara.as3.starling.core.controllers {
	import slavara.as3.core.commands.Command;
	import slavara.as3.core.data.Data;
	import slavara.as3.core.utils.IDestroyable;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingBaseController implements IBaseController, IDestroyable {
		
		public function StarlingBaseController(container:DisplayObjectContainer, data:Data) {
			_container = container;
			_data = data;
			initialize();
		}
		
		private var _container:DisplayObjectContainer;
		
		public function get container():DisplayObjectContainer {
			return _container;
		}
		
		private var _data:Data;
		
		public function get data():Data {
			return _data;
		}
		
		public function get baseController():IBaseController {
			return this;
		}
		
		private var _isDestroyed:Boolean;
		
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		public function destroy():void {
			_data = null;
			_container = null;
			_isDestroyed = true;
		}
		
		protected function initialize():void {
			_isDestroyed = false;
		}
	}
}