package slavara.as3.core.utils {
	import flash.events.EventDispatcher;
	
	/**
	 * @author SlavaRa
	 */
	public class StateMachineEventDispatcher extends EventDispatcher {
		
		public function StateMachineEventDispatcher() {
			super();
		}
		
		private var _transitionListeners:Object/*of Vector.<Function>*/;
		
		public function destroy():void {
			removeTransitionListeners();
			_transitionListeners = null;
		}
		
		public function reset():void {
			_transitionListeners = { };
		}
		
		public function addTransitionListener(from:String, to:String, listener:Function/*():void*/):void {
			if (_transitionListeners[from] == null) _transitionListeners[from] = { };
			var listeners:Vector.<Function/*():void*/> = _transitionListeners[from][to];
			if (listeners == null) listeners = _transitionListeners[from][to] = new <Function>[];/*():void*/
			if(listeners.indexOf(listener) == -1) listeners.push(listener);
		}
		
		public function removeTransitionListener(from:String, to:String, listener:Function/*():void*/):void {
			const toState2listeners:Object = _transitionListeners[from];
			if (toState2listeners == null)  return;
			const listeners:Vector.<Function/*():void*/> = toState2listeners[to];
			if(listeners == null) return;
			const index:int = listeners.indexOf(listener);
			if(index != -1) listeners.splice(index, 1);
			if(listeners == null || listeners.length == 0) delete toState2listeners[to];
			for(var key:* in toState2listeners) {
				if(key != null) return;
			}
			delete _transitionListeners[from];
		}
		
		public function removeTransitionListeners():void {
			for (var key:* in _transitionListeners) {
				delete _transitionListeners[key];
			}
		}
		
		protected function broadcastStateChange(from:String, to:String):void {
			callListeners(_transitionListeners[StateMachine.ANY_TRANSITION], to);
			callListeners(_transitionListeners[from], to);
		}
		
		private function callListeners(listeners:Object, to:String):void {
			if (listeners == null) return;
			$callListeners(listeners[StateMachine.ANY_TRANSITION]);
			$callListeners(listeners[to]);
		}
		
		private function $callListeners(listeners:Object):void {
			for each (var foo:Function in listeners) {
				if(foo != null) foo();
			}
		}
	}
}