package slavara.as3.game.starling.gui.windows {
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.StateMachineEnum;
	import slavara.as3.game.starling.enums.gui.StateWindowEnum;
	import slavara.as3.game.starling.gui.builders.GUIBuilder;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.gui.GUIItem;
	import starling.animation.IAnimatable;
	
	/**
	 * @author SlavaRa
	 */
	public class BaseWindow extends GUIItem implements IAnimatable{
		
		public function BaseWindow(builder:IGUIBuilder = null, config:GUIConfig = null) {
			super(builder || new GUIBuilder(config));
			
			_onOpened = new Signal();
			_onClosed = new Signal();
		}
		
		protected override function configureStateMachine():void {
			stateMachine.add(StateWindowEnum.CLOSED, StateWindowEnum.OPEN, StateWindowEnum.OPENING);
			stateMachine.add(StateWindowEnum.OPEN, StateWindowEnum.CLOSED, StateWindowEnum.CLOSING);
			
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateWindowEnum.OPENING, onOpeningState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateWindowEnum.OPEN, onOpenState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateWindowEnum.CLOSING, onClosingState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateWindowEnum.CLOSED, onClosedState);
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		public function advanceTime(time:Number):void {
		}
		
		public function open():BaseWindow {
			stateMachine.setState(StateWindowEnum.OPEN);
			return this;
		}
		
		public function close():BaseWindow {
			stateMachine.setState(StateWindowEnum.CLOSED);
			return this;
		}
		
		private var _onOpened:Signal;
		private var _onClosed:Signal;
		
		private function onOpeningState():void {
			//opening
			stateMachine.release();
		}
		
		private function onOpenState():void {
			_onOpened.dispatch(this);
		}
		
		private function onClosingState():void {
			//closing
			stateMachine.release();
		}
		
		private function onClosedState():void {
			_onClosed.dispatch(this);
		}
		
		public function get onOpened():Signal {
			return _onOpened;
		}
		
		public function get onClosed():Signal {
			return _onClosed;
		}
		
		public function get isOpen():Boolean {
			return stateMachine.currentState === StateWindowEnum.OPEN;
		}
		
	}
}