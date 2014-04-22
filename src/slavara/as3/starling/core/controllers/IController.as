package slavara.as3.starling.core.controllers {
	import flash.events.IEventDispatcher;
	import slavara.as3.core.data.Data;
	
	/**
	 * @author SlavaRa
	 */
	public interface IController {
		function get data():Data;
		function get baseController():IBaseController
	}
}