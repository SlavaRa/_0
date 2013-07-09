package slavara.as3.game.starling.controllers {
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.commands.Command;
	import slavara.as3.core.commands.CommandDispatcher;
	import slavara.as3.core.data.Data;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.IDestroyable;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author СлаваRa
	 */
	public class StarlingBaseController extends CommandDispatcher implements IStarlingBaseController, IDestroyable {
		
		public function StarlingBaseController(container:DisplayObjectContainer, data:Data) {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(data, "data");
			}
			
			super();
			if (Object(this).constructor === StarlingBaseController) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
			_isDestroyed = false;
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
		public function get baseController():IStarlingBaseController {
			return this;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function destroy():void {
			if(_isDestroyed){
				return;
			}
			removeCommandListeners();
			removeListeners();
			destroyView();
			view = null;
			_data = null;
			_container = null;
			_isDestroyed = true;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		protected var view:DisplayObject;
		
		protected function initialize():void {
			initializeView();
			addListeners();
		}
		
		/**virtual*/
		protected function initializeView():void {
		}
		
		/**virtual*/
		protected function addListeners():void {
		}
		
		/**virtual*/
		protected function removeListeners():void {
		}
		
		/**virtual*/
		protected function destroyView():void {
		}
		
		public function call(commandName:String, ...args):* {
			dispatchCommand(new Command(commandName, args));
		}
		
		private var _isDestroyed:Boolean;
		private var _container:DisplayObjectContainer;
		private var _data:Data;
		
	}
}