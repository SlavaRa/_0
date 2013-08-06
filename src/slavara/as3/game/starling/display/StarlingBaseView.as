package slavara.as3.game.starling.display {
	import slavara.as3.core.statemachine.IStateMachine;
	import slavara.as3.core.statemachine.StateMachine;
	import slavara.as3.core.utils.IStateMachineHolder;
	import slavara.as3.core.utils.Validate;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingBaseView extends Sprite {
		
		public function StarlingBaseView(data:IStateMachineHolder = null) {
			super();
			_dataStateMachine = Validate.isNotNull(data) ? data.stateMachine : null;
			initialize();
			addListeners();
			configureStateMachine();
		}
		
		public override function dispose():void {
			if(Validate.isNotNull(_dataStateMachine)) {
				_dataStateMachine.onChange.remove(onDataChange);
				_dataStateMachine.onReset.remove(stateMachine.reset);
				_dataStateMachine = null;
			}
			stateMachine.destroy();
			stateMachine = null;
			super.dispose();
		}
		
		public function setxy(x:Number, y:Number):void {
			super.x = x;
			super.y = y;
		}
		
		protected var stateMachine:StateMachine;
		
		protected function initialize():void {
			_onAddedToStage = false;
			initializeStateMachine();
		}
		
		/** virtual */
		protected function configureStateMachine():void { }
		
		/** virtual */
		protected function onAddedToStage():void { }
		
		/** virtual */
		protected function onRemovedFromStage():void { }
		
		private var _onAddedToStage:Boolean;
		private var _dataStateMachine:IStateMachine;
		
		private function addListeners():void {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		private function onAddedToStageHandler(event:Event):void {
			if(_onAddedToStage) {
				event.stopImmediatePropagation();
			} else {
				_onAddedToStage = true;
				onAddedToStage();
			}
		}
		
		private function onRemovedFromStageHandler(event:Event):void {
			_onAddedToStage = false;
			onRemovedFromStage();
		}
		
		private function initializeStateMachine():void {
			stateMachine = new StateMachine();
			if(Validate.isNull(_dataStateMachine)) {
				return;
			}
			_dataStateMachine.onChange.add(onDataChange);
			_dataStateMachine.onReset.add(stateMachine.reset);
		}
		
		private function onDataChange():void {
			stateMachine.setState(_dataStateMachine.currentState);
		}
		
	}
}