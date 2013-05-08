package slavara.as3.core.data {
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class DataStateMachine extends Data {
		
		public function DataStateMachine() {
			super();
			initialize();
		}
		
		public function reset():void {
			_to = null;
			_onReset.dispatch();
		}
		
		public function setState(to:BaseEnum):void {
			_to = to;
			_onChange.dispatch();
		}
		
		private var _to:BaseEnum;
		private var _onChange:Signal;
		private var _onReset:Signal;
		
		public function get state():BaseEnum {
			return _to;
		}
		
		private function initialize():void {
			_to = null;
			_onChange = new Signal();
			_onReset = new Signal();
		}
		
		public function get onChange():Signal {
			return _onChange;
		}
		
		public function get onReset():Signal {
			return _onReset;
		}
		
	}
}