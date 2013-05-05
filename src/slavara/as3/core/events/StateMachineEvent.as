package slavara.as3.core.events {
	import flash.events.Event;
	
	/**
	 * @author SlavaRa
	 */
	public class StateMachineEvent extends Event {
		
		public static const CHANGE:String = "change";
		
		public function StateMachineEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new StateMachineEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("StateMachineEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}