package slavara.as3.game.starling.managers.drag {
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.osflash.signals.Signal;
	import slavara.as3.core.utils.Validate;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	use namespace $internal;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDragManager {
		
		public static function startDrag(dragSource:DisplayObject, tex:Texture, rescale:Boolean = false, lockCenter:Boolean = true, bounds:Rectangle = null):void {
			instance.startDrag(dragSource, tex, rescale, lockCenter, bounds);
		}
		
		private static var _instance:StarlingDragManager;
		private static var _isInitialized:Boolean = true;
		private static const _POS:Point = new Point();
		//private static const _OBJECTS_UNDER_DRAG_OBJECT:Vector.<DisplayObject> = new <DisplayObject>[];
		
		public static function get instance():StarlingDragManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new StarlingDragManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public function StarlingDragManager() {
			super();
			CONFIG::debug
			{
				if (_isInitialized) {
					throw new Error("Singleton, use StarlingDragManager.instance");
				}
			}
			initialize();
		}
		
		public function stopDrag():void {
			if (Validate.isNull(_dragSource)) {
				throw new IllegalOperationError();
			}
			_onDragStop.dispatch();
			clear();
		}
		
		public function startDrag(dragSource:DisplayObject, tex:Texture, rescale:Boolean = false, lockCenter:Boolean = true, bounds:Rectangle = null):void {
			if(Validate.isNull(dragSource)) {
				return;
			}
			if(Validate.isNull(tex)) {
				throw new ArgumentError();
			}
			if(_dragSource === dragSource) {
				return;
			}
			
			if(Validate.isNotNull(_dragSource)) {
				clear();
			}
			
			_dragSource = dragSource;
			
			if(!lockCenter) {
				_POS.setTo(Starling.current.nativeOverlay.mouseX, Starling.current.nativeOverlay.mouseY);
				dragSource.globalToLocal(_POS, _POS);
			}
			
			_dragObject = StarlingDragObject.$getInstance(dragSource, tex, rescale, lockCenter, lockCenter ? null : _POS, bounds);
			_dragSource.addEventListener(Event.REMOVED_FROM_STAGE, onDragSourceRemovedFromStage);
			
			const stage:Stage = Starling.current.stage;
			stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
			
			//TODO: доделать определение dropTarget
			//_MOUSE_POS.x = Starling.current.nativeOverlay.mouseX;
			//_MOUSE_POS.y = Starling.current.nativeOverlay.mouseY;
			//StarlingDisplayUtils.getObjectsUnderPoint(stage, _MOUSE_POS, _OBJECTS_UNDER_DRAG_OBJECT);
			//_dropTarget = Collection.isNotEmpty(_OBJECTS_UNDER_DRAG_OBJECT) ? _OBJECTS_UNDER_DRAG_OBJECT[0] : null;
			stage.addChild(_dragObject);
			_onDragStart.dispatch();
		}
		
		//TODO:
		private function onDragSourceRemovedFromStage(event:Event):void {
			//DisplayObject(event.target).removeEventListener(Event.REMOVED_FROM_STAGE, onDragSourceRemovedFromStage);
			//if (_dragSource === event.target) {
				//clear();
				//_onDragFail.dispatch();
			//}
		}
		
		private function onStageTouch(event:TouchEvent):void {
			const target:DisplayObject = DisplayObject(event.target);
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.MOVED))) {
				_onDragMove.dispatch();
			}
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.ENDED))) {
				stopDrag();
			}
			//if(Validate.isNotNull(event.getTouch(target, TouchPhase.HOVER))) {
				//TODO: set drop target
			//}
		}
		
		private function onStageKeyUp(event:KeyboardEvent):void {
			if (event.keyCode === Keyboard.ESCAPE) {
				_onDragFail.dispatch();
				clear();
			}
		}
		
		private function clear():void {
			const stage:Stage = Starling.current.stage;
			if (Validate.isNotNull(_dragObject) && Validate.isNotNull(_dragObject.$parent)) {
				stage.removeChild(_dragObject);
			}
			
			if (Validate.isNotNull(_dragSource) && Validate.isNotNull(_dragSource.stage)) {
				_dragSource.removeEventListener(Event.REMOVED_FROM_STAGE, onDragSourceRemovedFromStage);
				
				stage.removeEventListener(TouchEvent.TOUCH, onStageTouch);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
			}
			
			_dragSource = null;
			_dragObject = null;
			_dropTarget = null;
		}
		
		//private function handler_mouseOver(event:MouseEvent):void {
			//this._dropTarget = event.target as DisplayObject;
		//}
		//
		//private function handler_mouseOut(event:MouseEvent):void {
			//this._dropTarget = null;
		//}
		
		private var _onDragStart:Signal;
		private var _onDragMove:Signal;
		private var _onDragStop:Signal;
		private var _onDragFail:Signal;
		private var _dropTarget:DisplayObject;
		private var _dragSource:DisplayObject;
		private var _dragObject:StarlingDragObject;
		
		private function initialize():void {
			_onDragStart = new Signal();
			_onDragMove = new Signal();
			_onDragStop = new Signal();
			_onDragFail = new Signal();
		}
		
		public function get onDragStart():Signal {
			return _onDragStart;
		}
		
		public function get onDragMove():Signal {
			return _onDragMove;
		}
		
		public function get onDragStop():Signal {
			return _onDragStop;
		}
		
		public function get onDragFail():Signal {
			return _onDragFail;
		}
		
		public function get dropTarget():DisplayObject {
			return _dropTarget;
		}
		
		public function get dragSource():DisplayObject {
			return _dragSource;
		}
		
		public function get dragObject():StarlingDragObject {
			return _dragObject;
		}
	
	}
}