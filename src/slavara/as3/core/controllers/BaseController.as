package slavara.as3.core.controllers {
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.commands.Command;
	import slavara.as3.core.commands.CommandDispatcher;
	import slavara.as3.core.data.Data;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.IDestroyable;
	
	/**
	 * @author SlavaRa
	 */
	public class BaseController extends CommandDispatcher implements IBaseController, IDestroyable {
		
		public function BaseController(container:DisplayObjectContainer, data:Data) {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(data, "data");
			}
			super();
			if (Object(this).constructor === BaseController) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
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
			removeCommandListeners();
			_data = null;
			_container = null;
			_isDestroyed = true;
		}
		
		public function call(commandName:String, ...args):* {
			dispatchCommand(new Command(commandName, args));
		}
		
		protected function initialize():void {
			_isDestroyed = false;
		}
	}
}