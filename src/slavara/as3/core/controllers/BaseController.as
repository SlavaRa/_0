package slavara.as3.core.controllers {
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.commands.Command;
	import slavara.as3.core.commands.CommandDispatcher;
	import slavara.as3.core.data.Data;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.IDestroyable;
	
	/**
	 * @author СлаваRa
	 */
	public class BaseController extends CommandDispatcher implements IBaseController, IDestroyable {
		
		public function BaseController(container:DisplayObjectContainer, data:Data) {
			Assert.isNull(container, "container");
			Assert.isNull(data, "data");
			super();
			if ((this as Object).constructor === BaseController) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
			_container = container;
			_data = data;
			initialize();
		}
		
		/* INTERFACE slavara.as3.core.controllers.IBaseController */
		public function get container():DisplayObjectContainer {
			return _container;
		}
		
		/* INTERFACE slavara.as3.core.controllers.IController */
		public function get data():Data {
			return _data;
		}
		
		/* INTERFACE slavara.as3.core.controllers.IController */
		public function get baseController():IBaseController {
			return this;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function destroy():void {
			removeCommandListeners();
			_data = null;
			_container = null;
			_isDestroyed = true;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		public function call(commandName:String, ...args):* {
			dispatchCommand(new Command(commandName, args));
		}
		
		protected function initialize():void {
			_isDestroyed = false;
		}
		
		private var _container:DisplayObjectContainer;
		private var _data:Data;
		private var _isDestroyed:Boolean;
		
	}
}