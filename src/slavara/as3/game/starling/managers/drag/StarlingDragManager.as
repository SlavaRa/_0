package slavara.as3.game.starling.managers.drag {
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.osflash.signals.Signal;
	import slavara.as3.core.utils.Validate;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	use namespace $internal;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDragManager {
		
		public static const manager:StarlingDragManager = new StarlingDragManager();
		private static const _OFFSET:Point = new Point();
		
		public static function startDrag(dragSource:DisplayObject, tex:Texture, rescale:Boolean = false, lockCenter:Boolean = true, bounds:Rectangle = null, onStage:Boolean = true):void {
			if(Validate.isNull(dragSource)) {
				return;
			}
			if(Validate.isNull(tex)) {
				throw new ArgumentError();
			}
			manager.startDrag(dragSource, tex, rescale, lockCenter, bounds, onStage);
		}
		
		public static function stopDrag():void {
			manager.stopDrag();
		}
		
		public function StarlingDragManager() {
			super();
			CONFIG::debug
			{
				if (Validate.isNotNull(manager)) {
					throw new Error("Singleton, use StarlingDragManager.manager");
				}
			}
			initialize();
		}
		
		private var _onDragStart:Signal;
		private var _onDragMove:Signal;
		private var _onDragStop:Signal;
		private var _onDragFail:Signal;
		private var _dropTarget:DisplayObject;//TODO: сделать определение
		private var _dragSource:DisplayObject;
		private var _dragObject:StarlingDragObject;
		
		private function initialize():void {
			_onDragStart = new Signal();
			_onDragMove = new Signal();
			_onDragStop = new Signal();
			_onDragFail = new Signal();
		}
		
		private function stopDrag():void {
			if (Validate.isNull(_dragSource)) {
				throw new IllegalOperationError();
			}
			_onDragStop.dispatch();
			clear();
		}
		
		//TODO: возможно необходимо избавиться от поля tex, и получать "скриншот" объект прямо здесь
		private function startDrag(dragSource:DisplayObject, tex:Texture, rescale:Boolean, lockCenter:Boolean, bounds:Rectangle, onStage:Boolean):void {
			if(dragSource === _dragSource) {
				return;
			}
			
			if(Validate.isNotNull(_dragSource)) {
				clear();
			}
			
			_dragSource = dragSource;
			
			if(!lockCenter) {
				_OFFSET.setTo(Starling.current.nativeOverlay.mouseX, Starling.current.nativeOverlay.mouseY);
				dragSource.globalToLocal(_OFFSET, _OFFSET);
			}
			
			_dragObject = StarlingDragObject.$getInstance(dragSource, tex, rescale, lockCenter, lockCenter ? null : _OFFSET, bounds, onStage);
			
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
			Starling.current.stage.addChild(_dragObject);
			
			_onDragStart.dispatch();
		}
		
		private function onStageTouch(event:TouchEvent):void {
			const target:DisplayObject = DisplayObject(event.target);
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.MOVED))) {
				_onDragMove.dispatch();
			}
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.ENDED))) {
				stopDrag();
			}
		}
		
		private function onStageKeyUp(event:KeyboardEvent):void {
			if (event.keyCode === Keyboard.ESCAPE) {
				_onDragFail.dispatch();
				clear();
			}
		}
		
		private function clear():void {
			if (Validate.isNotNull(_dragObject) && Validate.isNotNull(_dragObject.$parent)) {
				_dragObject.$parent.removeChild(_dragObject);
			}
			
			Starling.current.stage.removeEventListener(TouchEvent.TOUCH, onStageTouch);
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
			
			_dragSource = null;
			_dragObject = null;
			_dropTarget = null;
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