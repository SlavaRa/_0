package slavara.as3.core.utils {
	import flash.events.Event;
	
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * @author SlavaRa
	 */
	public final class StateMachine extends StateMachineEventDispatcher implements IStateMachine {
		
		public static const ANY_TRANSITION:String = "$_ANY_TRANSITION_$";
		
		public function StateMachine() {
			super();
			reset();
		}
		
		private var _transitions:Object;
		private var _inTransition:Boolean;
		private var _statesQueue:Vector.<String>;
		private var _queuedState:String;
		
		private var _curState:String;
		
		public function get currentState():String {
			return _curState;
		}
		
		private var _prevState:String;
		
		public function get previousState():String {
			return _prevState;
		}
		
		public override function reset():void {
			super.reset();
			_inTransition = false;
			_transitions = { };
		}
		
		public function setState(to:String):void {
			if (_inTransition) {
				_queuedState = to;
				return;
			}
			_queuedState = null;
			const curState2toState:Object = _transitions[_curState];
			if (curState2toState == null) return;
			const transition:Transition = curState2toState[to] as Transition;
			if (transition == null) return;
			_prevState = _curState;
			if (transition.simple) {
				_curState = transition.to;
				if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
				broadcastStateChange(transition.from, transition.to);
			} else {
				_inTransition = true;
				_statesQueue = transition.queue;
				setNextQueuedState();
			}
		}
		
		public override function destroy():void {
			_curState = null;
			_prevState = null;
			_transitions = null;
			_inTransition = false;
			_statesQueue = null;
			_queuedState = null;
			super.destroy();
		}
		
		/**
		 * @param via String || Array of String || Vector.<String>
		 */
		public function add(from:String, to:String = null, via:* = null):void {
			if (_curState == null) _curState = from;
			if (to == null || to.length == 0) return;
			var toState2Transition:Object = _transitions[from];
			if (toState2Transition == null) toState2Transition = _transitions[from] = { };
			if (via != null) {
				if (via is String) via = new <String>[via];
				else if (via is Array) via = Vector.<String>(via);
				else if (!(via is Vector.<String>)) Error.throwError(TypeError, 0, "via");
			}
			toState2Transition[to] = new Transition(from, to, via);
		}
		
		public function release():void {
			setNextQueuedState();
		}
		
		private function setNextQueuedState():void {
			_prevState = _curState;
			_curState = _statesQueue.shift();
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
			broadcastStateChange(_prevState, _curState);
			if (_statesQueue.length == 0) _inTransition = false;
			if (!_inTransition || _transitions[_curState] != null) {
				if (_queuedState != null) {
					if (_transitions[_curState][_queuedState] is Transition) {
						_inTransition = false;
						_statesQueue = null;
						setState(_queuedState);
					}
				} else if (_inTransition) setNextQueuedState();
			}
		}
		
	}
}

class Transition {
	
	public function Transition(from:String, to:String, via:Vector.<String> = null) {
		super();
		this.from = from;
		this.to = to;
		if (via != null) {
			_queue = via.slice();
			_queue.push(to);
		}
	}
	
	public var from:String;
	public var to:String;
	
	private var _queue:Vector.<String>;
	
	public function get queue():Vector.<String> {
		return _queue != null ? _queue.slice() : [];
	}
	
	public function get simple():Boolean {
		return _queue == null || _queue.length == 0;
	}
}