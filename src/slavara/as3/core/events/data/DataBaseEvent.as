package slavara.as3.core.events.data {
	
	import slavara.as3.core.data.DataBaseNativeEvent;
	
	public class DataBaseEvent extends DataBaseNativeEvent {
		
		public static const ADDED:String = "added";
		public static const REMOVED:String = "removed";
		public static const CHANGE:String = "change";
		public static const MOUSE_ENABLED_CHANGE:String = "mouseEnabledChange";
		
		public function DataBaseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}