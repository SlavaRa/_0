package slavara.as3.core.statemachine {
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public interface IStateMachine {
		function reset():void;
		function setState(to:BaseEnum):void;
		
		function get onChange():Signal;
		function get onReset():Signal;
		function get currentState():BaseEnum;
		function get previousState():BaseEnum;
	}
}