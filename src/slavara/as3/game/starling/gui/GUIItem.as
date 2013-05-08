package slavara.as3.game.starling.gui {
	import slavara.as3.core.statemachine.StateMachine;
	import slavara.as3.core.utils.DestroyUtils;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.game.starling.gui.builders.GUIBuilder;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public class GUIItem implements IDestroyable {
		
		public function GUIItem(builder:IGUIBuilder = null, config:GUIConfig = null) {
			super();
			initialize(builder || new GUIBuilder(config));
			configureStateMachine();
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function destroy():void {
			DestroyUtils.destroy(_builder);
			DestroyUtils.destroy(_stateMachine);
			_builder = null;
			_stateMachine = null;
			_isDestroyed = true;
		}
		
		/* INTERFACE slavara.as3.core.utils.IDestroyable */
		public function get isDestroyed():Boolean {
			return _isDestroyed;
		}
		
		/* DELEGATE slavara.as3.game.starling.gui.builders.IGUIBuilder */
		public function build():void {
			_builder.build();
		}
		
		protected function initialize(builder:IGUIBuilder):void {
			_isDestroyed = false;
			_builder = builder;
			_stateMachine = new StateMachine();
		}
		
		protected function configureStateMachine():void {
		}
		
		private var _isDestroyed:Boolean;
		private var _builder:IGUIBuilder;
		private var _stateMachine:StateMachine;
		
		public function get view():DisplayObjectContainer {
			return _builder.getProduct();
		}
		
		protected function get stateMachine():StateMachine {
			return _stateMachine;
		}
		
	}
}