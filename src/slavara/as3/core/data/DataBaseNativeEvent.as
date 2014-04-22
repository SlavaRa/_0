package slavara.as3.core.data {
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import slavara.as3.core.events.data.DataBaseEvent;
	import slavara.as3.core.utils.Validate;
	
	[Exclude(name="property",kind="stopped")]
	[Exclude(name="property",kind="canceled")]
	[Exclude(name="property",kind="target")]
	[Exclude(name="property",kind="eventPhase")]
	
	public class DataBaseNativeEvent extends Event {
		
		use namespace $internal;
		
		public function DataBaseNativeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			CONFIG::debug
			{
				if (!(this is DataBaseEvent)) {
					Error.throwError(IllegalOperationError, 2012, "DataBaseNativeEvent");
				}
			}
			super(type, bubbles, cancelable);
		}
		
		$internal var $target:Object;
		
		public override function get target():Object {
			return $target || super.target;
		}
		
		$internal var $eventPhase:uint;
		
		public override function get eventPhase():uint {
			return $eventPhase || super.eventPhase;
		}
		
		$internal var $stopped:Boolean = false;
		
		public override function stopPropagation():void {
			$stopped = true;
		}
		
		$internal var $canceled:Boolean = false;
		
		public override function isDefaultPrevented():Boolean {
			return $canceled;
		}
		
		public override function preventDefault():void {
			if(super.cancelable) {
				super.preventDefault();
				$canceled = true;
			}
		}
		
		public override function stopImmediatePropagation():void {
			super.stopImmediatePropagation();
			$stopped = true;
		}
		
		public override function formatToString(className:String, ... rest):String {
			if(!Validate.stringIsNullOrEmpty(className)) {
				className = "DataBaseNativeEvent";
				(rest as Array).unshift(className);
			}
			return super.formatToString.apply(this, rest);
		}
		
		public override function toString():String {
			return super.formatToString("DataBaseNativeEvent", "type", "bubbles", "cancelable");
		}
		
		public override function clone():Event {
			const cls:Class = Class(Object(this).constructor);
			return new cls(super.type, super.bubbles, super.cancelable);
		}
	}
}