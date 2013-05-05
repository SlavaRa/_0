package slavara.as3.core.statemachine {
	import flash.utils.Dictionary;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Assert;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public final class StateMachine extends StateMachineEventDispatcher {
		
		public function StateMachine() {
			super();
			reset();
		}
		
		public override function reset():void {
			_inTransition = false;
			_canChangeState = true;
			_transitions = new Dictionary(true);
			super.reset();
		}
		
		public override function destroy():void {
			_canChangeState = false;
			_currentState = null;
			_previousState = null;
			_transitions = null;
			_inTransition = false;
			_statesQueue = null;
			_queuedState = null;
			super.destroy();
		}
		
		/**
		 * @param	via BaseEnum || Array of BaseEnum || Vector.<BaseEnum>
		 */
		public function add(from:BaseEnum, to:BaseEnum = null, via:* = null):void {
			Assert.isNull(from, "from");
			
			if (Validate.isNull(_currentState)) {
				_currentState = from;
			}
			
			if (Validate.isNotNull(to)) {
				var toState2Transition:Dictionary = _transitions[from] as Dictionary;
				if (Validate.isNull(toState2Transition)) {
					toState2Transition = _transitions[from] = new Dictionary();
				}
				
				if (Validate.isNotNull(via)) {
					if (via is BaseEnum) {
						via = new <BaseEnum>[via];
					} else if (via is Array) {
						via = Vector.<BaseEnum>(via);
					} else if (!(via is Vector.<BaseEnum>)) {
						Error.throwError(TypeError, 0, "via");
					}
				}
				
				toState2Transition[to] = new Transition(from, to, via);
			}
		}
		
		public function setState(to:BaseEnum):void {
			if (_inTransition && _canChangeState) {
				_queuedState = to;
				return;
			} else {
				_queuedState = null;
			}
			
			const curState2toState:Dictionary = _transitions[_currentState] as Dictionary;
			if (Validate.isNotNull(curState2toState)) {
				const transition:Transition = curState2toState[to] as Transition;
				if (Validate.isNotNull(transition)) {
					_previousState = _currentState;
					
					if (transition.simple) {
						_currentState = transition.to;
						broadcastStateChange(transition.from, transition.to);
					} else {
						_inTransition = true;
						_statesQueue = transition.queue;
						setNextQueuedState();
					}
				}
			}
		}
		
		public function release():void {
			setNextQueuedState();
		}
		
		private var _canChangeState:Boolean;
		private var _currentState:BaseEnum;
		private var _previousState:BaseEnum;
		private var _transitions:Dictionary;
		private var _inTransition:Boolean;
		private var _statesQueue:Vector.<BaseEnum>;
		private var _queuedState:BaseEnum;
		
		private function setNextQueuedState():void {
			_previousState = _currentState;
			_currentState = _statesQueue.shift();
			
			broadcastStateChange(_previousState, _currentState);
			
			if (Validate.collectionIsNotEmpty(_statesQueue)) {
				_inTransition = false;
			}
			
			if (!_inTransition || Validate.isNotNull(_transitions[_currentState])) {
				if (Validate.isNotNull(_queuedState)) {
					if (_transitions[_currentState][_queuedState] is Transition) {
						_inTransition = false;
						_statesQueue = null;
						setState(_queuedState);
					}
				} else if (_inTransition) {
					setNextQueuedState();
				}
			}
		}
		
		public function get canChangeState():Boolean {
			return _canChangeState;
		}
		
		public function set canChangeState(value:Boolean):void {
			_canChangeState = value;
		}
		
		public function get currentState():BaseEnum {
			return _currentState;
		}
		
		public function get previousState():BaseEnum {
			return _previousState;
		}
		
	}
}

import slavara.as3.core.enums.BaseEnum;
import slavara.as3.core.utils.Validate;
class Transition {
	
	public function Transition(from:BaseEnum, to:BaseEnum, via:Vector.<BaseEnum> = null) {
		super();
		_from = from;
		_to = to;
		
		if (Validate.isNotNull(via)) {
			_queue = via.slice();
			_queue.push(_to);
		}
	}
	
	private var _from:BaseEnum;
	private var _to:BaseEnum;
	private var _queue:Vector.<BaseEnum>;
	
	public function get from():BaseEnum {
		return _from;
	}
	
	public function get to():BaseEnum {
		return _to;
	}
	
	public function get queue():Vector.<BaseEnum> {
		return Validate.isNotNull(_queue) ? _queue.slice() : null;
	}
	
	public function get simple():Boolean {
		return Validate.collectionIsNullOrEmpty(_queue);
	}

}