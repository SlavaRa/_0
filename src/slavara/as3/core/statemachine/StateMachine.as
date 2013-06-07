package slavara.as3.core.statemachine {
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public final class StateMachine extends StateMachineEventDispatcher implements IStateMachine {
		
		public function StateMachine() {
			super();
			reset();
		}
		
		//{ region INTERFACE slavara.as3.core.statemachine.IStateMachine
		
		public override function reset():void {
			super.reset();
			_inTransition = false;
			_transitions = new Dictionary(true);
			_onReset.dispatch();
		}
		
		public function setState(to:BaseEnum):void {
			if (_inTransition) {
				_queuedState = to;
				return;
			} else {
				_queuedState = null;
			}
			
			const curState2toState:Dictionary = _transitions[_curState] as Dictionary;
			if (Validate.isNull(curState2toState)) {
				return;
			}
			
			const transition:Transition = curState2toState[to] as Transition;
			if (Validate.isNull(transition)) {
				return;
			}
			
			_prevState = _curState;
			
			if (transition.simple) {
				_curState = transition.to;
				_onChange.dispatch();
				broadcastStateChange(transition.from, transition.to);
			} else {
				_inTransition = true;
				_statesQueue = transition.queue;
				setNextQueuedState();
			}
		}
		
		public function get onChange():Signal {
			return _onChange;
		}
		
		public function get onReset():Signal {
			return _onReset;
		}
		
		public function get currentState():BaseEnum {
			return _curState;
		}
		
		public function get previousState():BaseEnum {
			return _prevState;
		}
		
		//} endregion INTERFACE slavara.as3.core.statemachine.IStateMachine
		
		public override function destroy():void {
			_curState = null;
			_prevState = null;
			_transitions = null;
			_inTransition = false;
			_statesQueue = null;
			_queuedState = null;
			super.destroy();
		}
		
		protected override function initialize():void {
			super.initialize();
			_onChange = new Signal();
			_onReset = new Signal();
		}
		
		/**
		 * @param	via BaseEnum || Array of BaseEnum || Vector.<BaseEnum>
		 */
		public function add(from:BaseEnum, to:BaseEnum = null, via:* = null):void {
			CONFIG::debug
			{
				Assert.isNull(from, "from");
			}
			
			if (Validate.isNull(_curState)) {
				_curState = from;
			}
			
			if (Validate.isNull(to)) {
				return;
			}
			
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
		
		public function release():void {
			setNextQueuedState();
		}
		
		private var _curState:BaseEnum;
		private var _prevState:BaseEnum;
		private var _transitions:Dictionary;
		private var _inTransition:Boolean;
		private var _statesQueue:Vector.<BaseEnum>;
		private var _queuedState:BaseEnum;
		private var _onChange:Signal;
		private var _onReset:Signal;
		
		private function setNextQueuedState():void {
			_prevState = _curState;
			_curState = _statesQueue.shift();
			_onChange.dispatch();
			
			broadcastStateChange(_prevState, _curState);
			
			if (Collection.isEmpty(_statesQueue)) {
				_inTransition = false;
			}
			
			if (!_inTransition || Validate.isNotNull(_transitions[_curState])) {
				if (Validate.isNotNull(_queuedState)) {
					if (_transitions[_curState][_queuedState] is Transition) {
						_inTransition = false;
						_statesQueue = null;
						setState(_queuedState);
					}
				} else if (_inTransition) {
					setNextQueuedState();
				}
			}
		}
		
	}
}

import slavara.as3.core.enums.BaseEnum;
import slavara.as3.core.utils.Validate;
class Transition {
	
	public function Transition(from:BaseEnum, to:BaseEnum, via:Vector.<BaseEnum> = null) {
		super();
		this.from = from;
		this.to = to;
		
		if (Validate.isNotNull(via)) {
			_queue = via.slice();
			_queue.push(to);
		}
	}
	
	public var from:BaseEnum;
	public var to:BaseEnum;
	
	private var _queue:Vector.<BaseEnum>;
	
	public function get queue():Vector.<BaseEnum> {
		return Validate.isNotNull(_queue) ? _queue.slice() : null;
	}
	
	public function get simple():Boolean {
		return Validate.collectionIsNullOrEmpty(_queue);
	}

}