package slavara.as3.game.starling.display {
	import slavara.as3.core.data.DataStateMachine;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.statemachine.StateMachine;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.core.utils.Validate;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author SlavaRa
	 */
	public class BaseView extends Sprite implements IDestroyable {
		
		public function BaseView(data:DataStateMachine = null) {
			super();
			_data = data;
			addListeners();
			initialize();
			configureStateMachine();
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function destroy():void {
			Assert.isTrue(_isDestroyed);
			removeEventListeners();
			destroyDataStateMachine();
			destroyStateMachine();
			_isDestroyed = true;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		protected var stateMachine:StateMachine;
		
		protected function initialize():void {
			_isDestroyed = false;
			_onAddedToStage = false;
			initializeStateMachine();
		}
		
		protected function configureStateMachine():void {
		}
		
		protected function onAddedToStage():void {
		}
		
		protected function onRemovedFromStage():void {
		}
		
		private var _data:DataStateMachine;
		private var _isDestroyed:Boolean;
		private var _onAddedToStage:Boolean;
		
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
			if(Validate.isNull(_data)) {
				return;
			}
			_data.onChange.add(onDataChange);
			_data.onReset.add(stateMachine.reset);
		}
		
		private function onDataChange():void {
			stateMachine.setState(_data.state);
		}
		
		private function destroyDataStateMachine():void {
			if(Validate.isNull(_data)) {
				return;
			}
			_data.onChange.remove(stateMachine.setState);
			_data.onReset.remove(stateMachine.reset);
			_data = null;
		}
		
		private function destroyStateMachine():void {
			stateMachine.destroy();
			stateMachine = null;
		}
	}
}