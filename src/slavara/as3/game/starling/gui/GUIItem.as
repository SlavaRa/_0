package slavara.as3.game.starling.gui {
	import flash.utils.Dictionary;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.statemachine.StateMachine;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.DestroyUtils;
	import slavara.as3.core.utils.IDestroyable;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.builders.GUIBuilder;
	import slavara.as3.game.starling.gui.builders.IGUIBuilder;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.display.DisplayObject;
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
			Collection.clear(_enum2child);
			_builder = null;
			_stateMachine = null;
			_enum2child = null;
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
		
		public function getChildByEnum(enum:BaseEnum, cache:Boolean = true):DisplayObject {
			if(cache) {
				if(!Collection.exists(enum, _enum2child)) {
					const child:DisplayObject = StarlingDisplayUtils.getDOby(_builder.getProduct(), enum);
					if(Validate.isNull(child)) {
						return null;
					}
					_enum2child[enum] = child;
				}
				return _enum2child[enum] as DisplayObject;
			}
			return StarlingDisplayUtils.getDOby(_builder.getProduct(), enum);
		}
		
		public function getChildByPath(path:Vector.<BaseEnum>):DisplayObject {
			return StarlingDisplayUtils.getChildByPath(_builder.getProduct(), path);
		}
		
		protected function initialize(builder:IGUIBuilder):void {
			_isDestroyed = false;
			_builder = builder;
			_stateMachine = new StateMachine();
			_enum2child = new Dictionary(true);
		}
		
		/**virtual*/
		protected function configureStateMachine():void {
		}
		
		private var _isDestroyed:Boolean;
		private var _builder:IGUIBuilder;
		private var _stateMachine:StateMachine;
		private var _enum2child:Dictionary;
		
		public function get view():DisplayObjectContainer {
			return _builder.getProduct();
		}
		
		protected function get stateMachine():StateMachine {
			return _stateMachine;
		}
		
	}
}