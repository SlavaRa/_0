package slavara.as3.core.data {
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.statemachine.IStateMachine;
	
	/**
	 * @author SlavaRa
	 */
	public class DataStateMachine extends Data implements IStateMachine {
		
		public function DataStateMachine() {
			super();
			initialize();
		}
		
		//{ region INTERFACE slavara.as3.core.statemachine.IStateMachine
		
		public function reset():void {
			_curState = null;
			_prevState = null;
			_onReset.dispatch();
		}
		
		public function setState(state:BaseEnum):void {
			_prevState = _curState
			_curState = state;
			_onChange.dispatch();
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
		
		private var _onChange:Signal;
		private var _onReset:Signal;
		private var _curState:BaseEnum;
		private var _prevState:BaseEnum;
		
		private function initialize():void {
			_curState = null;
			_prevState = null;
			_onChange = new Signal();
			_onReset = new Signal();
		}
		
	}
}