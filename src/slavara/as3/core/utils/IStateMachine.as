package slavara.as3.core.utils {
	
	/**
	 * @author SlavaRa
	 */
	public interface IStateMachine {
		function get currentState():String;
		function get previousState():String;
		function reset():void;
		function setState(to:String):void;
	}
}