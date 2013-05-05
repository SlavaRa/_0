package slavara.as3.game.starling.controllers {
	import starling.display.DisplayObjectContainer;
	import slavara.as3.core.commands.ICommandDispatcher;
	
	/**
	 * @author СлаваRa
	 */
	public interface IStarlingBaseController extends ICommandDispatcher, IStarlingController {
		function get container():DisplayObjectContainer;
	}

}