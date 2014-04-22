package slavara.as3.starling.core.controllers {
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public interface IBaseController extends IController {
		function get container():DisplayObjectContainer;
	}
}