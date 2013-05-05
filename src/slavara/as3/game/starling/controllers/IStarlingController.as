package slavara.as3.game.starling.controllers {
	import flash.events.IEventDispatcher;
	import slavara.as3.core.data.Data;
	
	/**
	 * @author СлаваRa
	 */
	public interface IStarlingController extends IEventDispatcher {
		function get data():Data;
		function get baseController():IStarlingBaseController
	}

}