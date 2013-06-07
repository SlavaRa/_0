package slavara.as3.core.data {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.events.data.DataBaseEvent;
	import slavara.as3.core.utils.Validate;
	
	[Event(type = "added", name = DataBaseEvent)]
	[Event(type = "removed", name = DataBaseEvent)]
	[Exclude(kind = "property", name = "$parent")]
	[Exclude(kind = "method", name = "$setParent")]
	
	[ExcludeClass]
	public class Data extends EventDispatcher {
		
		use namespace $internal;
		
		public function Data() {
			super();
			
			CONFIG::debug
			{
				if ((this as Object).constructor === Data) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
		public override function dispatchEvent(event:Event):Boolean {
			if (event.bubbles) {
				if (event is DataBaseEvent) {
					return dispatchEventFunction(event as DataBaseEvent);
				}
				throw new TypeError("bubbling поддерживается только у событий наследованных от DataBaseEvent");
			}
			return super.dispatchEvent(event);
		}
		
		public override function willTrigger(type:String):Boolean {
			if (super.hasEventListener(type)) {
				return true;
			}
			
			var target:Data = _bubbleParent;
			while (Validate.isNotNull(target)) {
				if (target.hasEventListener(type)) {
					return true;
				}
				target = target._bubbleParent;
			}
			return false;
		}
		
		public var name:String = '';
		
		private var _bubbleParent:DataContainer;
		$internal var $parent:DataContainer;
		
		$internal function $setParent(value:DataContainer):void {
			if (value === $parent) {
				return;
			}
			if (Validate.isNotNull($parent)) {
				removeFromParent();
			}
			$parent = value;
			_bubbleParent = value;
			if (Validate.isNotNull(value)) {
				dispatchEventFunction(new DataBaseEvent(DataBaseEvent.ADDED, true));
			}
		}
		
		private function removeFromParent():void {
			_bubbleParent = $parent;
			dispatchEventFunction(new DataBaseEvent(DataBaseEvent.REMOVED, true));
		}
		
		private function $dispatchEvent(event:Event):Boolean {
			return super.dispatchEvent(event);
		}
		
		private function dispatchEventFunction(event:DataBaseNativeEvent):Boolean {
			var canceled:Boolean = false;
			if (super.hasEventListener(event.type)) {
				canceled = !(super.dispatchEvent(event));
			}
			if (!event.$stopped) {
				var target:Data = _bubbleParent;
				while (target) {
					if (target.hasEventListener(event.type)) {
						event = DataBaseNativeEvent(event.clone());
						event.$eventPhase = EventPhase.BUBBLING_PHASE;
						event.$target = this;
						event.$canceled = canceled;
						CONTAINER.$event = event;
						target.$dispatchEvent(CONTAINER);
						canceled = event.$canceled;
						if (event.$stopped) {
							break;
						}
					}
					target = target._bubbleParent;
				}
			}
			return !canceled;
		}
		
		public function get parent():DataContainer {
			return $parent;
		}
		
	}
}

import flash.events.Event;
class EventContainer extends Event {
	public function EventContainer() {
		_target = {};
		super("", true, false);
	}
	
	private var _target:Object;
	internal var $event:Event;
	
	public override function get target():Object {
		return _target;
	}
	
	public override function clone():Event {
		return $event;
	}
}

internal var CONTAINER:EventContainer = new EventContainer();