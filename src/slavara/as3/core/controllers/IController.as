package slavara.as3.core.controllers {
	import flash.events.IEventDispatcher;
	import slavara.as3.core.data.Data;
	
	/**
	 * @author СлаваRa
	 */
	public interface IController extends IEventDispatcher {
		function get data():Data;
		function get baseController():IBaseController
	}

}