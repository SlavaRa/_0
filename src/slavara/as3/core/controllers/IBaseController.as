package slavara.as3.core.controllers {
	import flash.display.DisplayObjectContainer;
	import slavara.as3.core.commands.ICommandDispatcher;
	
	/**
	 * @author СлаваRa
	 */
	public interface IBaseController extends ICommandDispatcher, IController {
		function get container():DisplayObjectContainer;
	}

}