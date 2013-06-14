package slavara.as3.game.starling.managers.drag {
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.flashdevelop.utils.TraceLevel;
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
			_onDragFail.dispatch();
			clear();
		}
		
		public function startDrag(dragSource:DisplayObject, tex:Texture, rescale:Boolean = false, lockCenter:Boolean = true, bounds:Rectangle = null):void {
			if(Validate.isNull(dragSource)) {
				return;
			}
			if (Validate.isNull(tex)) {
				throw new ArgumentError();
			}
			if (_dragSource === dragSource) {
				return;
			}
			
			if (Validate.isNotNull(_dragSource)) {
				clear();
			}
			
			_dragSource = dragSource;
			_dragObject = StarlingDragObject.$getInstance(dragSource, tex, rescale, lockCenter, bounds);
			_dragSource.addEventListener(Event.REMOVED_FROM_STAGE, onDragSourceRemovedFromStage);
			
			const stage:Stage = Starling.current.stage;
			stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
			
			//_dropTarget = StarlingObjectUtils.getDropTarget(stage, new Point(stage.mouseX, stage.mouseY));
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
		
		/*	
		TODO: getObjectUnderPoint
		var nodes = [{c:stage, depth:0}];
		var res:Array<{c, depth}> = [];

		while (nodes.length > 0) {
		  var c = nodes.shift();
		  if (c.c.children.length == 0) {
			  res.push( p );
		  } else {
		  var i  = 0;
		  for (child in c.c.children) {
			if (child.hitTest(mousePos)) nodes.push({c:child, depth:c.depth + (i++));
		  }
		  }
		}
		}*/
		
		private function onStageTouch(event:TouchEvent):void {
			const target:DisplayObject = DisplayObject(event.target);
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.MOVED))) {
				_onDragMove.dispatch();
			}
			if(Validate.isNotNull(event.getTouch(target, TouchPhase.ENDED))) {
				event.stopImmediatePropagation();
				_onDragStop.dispatch();
				clear();
			}
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