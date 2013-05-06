package slavara.as3.game.starling.gui.windows {
	import org.osflash.signals.Signal;
	import slavara.as3.core.enums.StateMachineEnum;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.enums.gui.WindowsEnum;
	import slavara.as3.game.starling.enums.StateWindowEnum;
	import slavara.as3.game.starling.gui.builders.GUIBuilder;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.gui.GUIItem;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.animation.IAnimatable;
	import starling.display.DisplayObject;
	
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
			
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateMachineEnum.OPENING, onOpeningState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateMachineEnum.OPEN, onOpenState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateMachineEnum.CLOSING, onClosingState);
			stateMachine.addTransitionListener(StateMachineEnum.CHANGE, StateMachineEnum.CLOSED, onClosedState);
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		public function advanceTime(time:Number):void {
		}
		
		public function open():BaseWindow {
			stateMachine.setState(StateMachineEnum.OPEN);
			return this;
		}
		
		public function close():BaseWindow {
			stateMachine.setState(StateMachineEnum.CLOSED);
			return this;
		}
		
		/**
		 * если не передать координаты, окно центрируется
		 */
		protected function setPositionView(x:Number = NaN, y:Number = NaN):void {
			view.x = isNaN(x) ? int((view.stage.stageWidth  - view.width)  >> 1) : int(x);
			view.y = isNaN(y) ? int((view.stage.stageHeight - view.height) >> 1) : int(y);
		}
		
		/**
		 * если не передать координаты, заголовок центрируется
		 */
		protected function setPositionTitle(x:Number = NaN, y:Number = NaN):void {
			const title:DisplayObject = StarlingDisplayUtils.getChildByEnum(view, WindowsEnum.TITLE);
			if (Validate.isNull(title)) {
				return;
			}
			title.x = isNaN(x) ? int((view.width - title.width) >> 1) : int(x);
			title.y = isNaN(y) ? int(title.y) : int(y);
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
		
	}
}