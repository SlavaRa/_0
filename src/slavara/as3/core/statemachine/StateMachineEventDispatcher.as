package slavara.as3.core.statemachine {
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.enums.StateMachineEnum;
	import slavara.as3.core.utils.Callback;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public class StateMachineEventDispatcher implements IDestroyable{
		
		private static function validator(from:BaseEnum, to:BaseEnum, listener:Function/*():void*/):void {
			Assert.isNull(from, "from");
			Assert.isNull(to, "to");
			Assert.isNull(listener, "listener");
		}
		
		public function StateMachineEventDispatcher() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === StateMachineEventDispatcher) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
			
			initialize();
		}
		
		//{ region INTERFACE slavara.as3.core.utils.IDestroyable
		
		public function destroy():void {
			if(_isDestroyed){
				return;
			}
			removeTransitionListeners();
			_transitionListeners = null;
			_isDestroyed = true;
		}
		
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		//} endregion INTERFACE slavara.as3.core.utils.IDestroyable
		
		public function reset():void {
			Collection.clear(_transitionListeners);
		}
		
		public function addTransitionListener(from:BaseEnum, to:BaseEnum, listener:Function/*():void*/):void {
			CONFIG::debug
			{
				validator(from, to, listener);
			}
			
			if (Validate.isNull(_transitionListeners[from])) {
				_transitionListeners[from] = new Dictionary(true);
			}
			
			var listeners:Vector.<Function/*():void*/> = _transitionListeners[from][to];
			if (Validate.isNull(listeners)) {
				listeners = _transitionListeners[from][to] = new <Function>[];/*():void*/
			}
			
			if(!Collection.exists(listener, listeners)) {
				listeners.push(listener);
			}
		}
		
		public function removeTransitionListener(from:BaseEnum, to:BaseEnum, listener:Function/*():void*/):void {
			CONFIG::debug
			{
				validator(from, to, listener);
			}
			
			const toState2listeners:Dictionary = Dictionary(_transitionListeners[from]);
			if (Validate.isNull(toState2listeners)) {
				return;
			}
			
			const listeners:Vector.<Function/*():void*/> = toState2listeners[to];
			if(Validate.isNull(listeners)) {
				return;
			}
			
			Collection.remove(listener, listeners);
			
			if(Collection.isEmpty(listeners)) {
				delete toState2listeners[to];
			}
			
			if(Collection.nonEmpty(toState2listeners)) {
				return;
			}
			
			delete _transitionListeners[from];
		}
		
		public function removeTransitionListeners():void {
			for (var key:* in _transitionListeners) {
				Collection.clear(_transitionListeners[key]);
				delete _transitionListeners[key];
			}
		}
		
		protected function initialize():void {
			_isDestroyed = false;
			_transitionListeners = new Dictionary(true);
		}
		
		protected function broadcastStateChange(from:BaseEnum, to:BaseEnum):void {
			callListeners(_transitionListeners[StateMachineEnum.CHANGE], to);
			callListeners(_transitionListeners[from], to);
		}
		
		private var _isDestroyed:Boolean;
		private var _transitionListeners:Dictionary/*of Vector.<Function>*/;
		
		private function callListeners(listeners:Object, to:BaseEnum):void {
			if (Validate.isNotNull(listeners)) {
				$callListeners(listeners[StateMachineEnum.CHANGE]);
				$callListeners(listeners[to]);
			}
		}
		
		private function $callListeners(listeners:Object):void {
			for each (var foo:Function in listeners) {
				Callback.call(foo);
			}
		}
		
	}
}