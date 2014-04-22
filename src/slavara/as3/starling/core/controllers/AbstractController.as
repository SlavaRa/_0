package slavara.as3.starling.core.controllers {
	import slavara.as3.core.data.Data;
	import slavara.as3.core.utils.IDestroyable;
	import starling.events.EventDispatcher;
	
	/**
	 * @author SlavaRa
	 */
	public class AbstractController extends EventDispatcher implements IController, IDestroyable {
		
		public function AbstractController(controller:IBaseController) {
			_baseController = controller;
			initialize();
		}
		
		private var _baseController:IBaseController;
		
		public function get baseController():IBaseController {
			return _baseController;
		}
		
		
		public function get data():Data {
			return _baseController.data;
		}
		
		private var _isDestroyed:Boolean;
		
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		public function destroy():void {
			_baseController = null;
			_isDestroyed = true;
		}
		
		protected function initialize():void {
		}
	}
}