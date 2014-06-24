package {
	import flash.display.Sprite;
	import flash.events.Event;
	import slavara.as3.core.utils.StateMachine;
	
	/**
	 * @author SlavaRa
	 */
	public class StateMachineMain extends Sprite {
		
		public function StateMachineMain() {
			super();
			_smachine = new StateMachine();
			_smachine.add("Some_1", "Some_2", "Some_3");
			_smachine.add("Some_2", "Some_1");
			_smachine.addEventListener(Event.CHANGE, onSmachineChange);
			_smachine.addTransitionListener("Some_1", "Some_3", from1to3);
			onSmachineChange();
			_smachine.setState("Some_2");
		}
		
		private var _smachine:StateMachine;
		
		private function from1to3():void {
			_smachine.release();
		}
		
		private function onSmachineChange(event:Event = null):void {
			trace(_smachine.currentState);
		}
	}
}