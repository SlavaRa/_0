package slavara.as3.game.starling.managers.drag {
	import air.net.SecureSocketMonitor;
	import feathers.controls.ScreenNavigatorItem;
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.managers.drag.StarlingDragObject;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.textures.Texture;
	
	use namespace $internal;
	
	[Exclude(kind="property",name="graphics")]
	[Exclude(kind="property",name="parent")]
	[Exclude(kind="property",name="$parent")]
	[Exclude(kind="property",name="stage")]
	[Exclude(kind="property",name="visible")]
	[Exclude(kind="method",name="$getInstance")]
	
	/**
	 * @author SlavaRa
	 */
	public final class StarlingDragObject extends DisplayObjectContainer implements IAnimatable {
		
		private static var _internalCall:Boolean = false;
		private static const _PREV_POS:Point = new Point();
		private static const _TMP_POINT:Point = new Point();
		private static const _TMP_MATRIX:Matrix = new Matrix();
		
		$internal static function $getInstance(dragSource:DisplayObject, tex:Texture, rescale:Boolean = false, lockCenter:Boolean = true, offset:Point = null, bounds:Rectangle = null, onStage:Boolean = true):StarlingDragObject {
			_internalCall = true;
			const result:StarlingDragObject = new StarlingDragObject(dragSource, tex, rescale, lockCenter, offset, bounds, onStage);
			_internalCall = false;
			return result;
		}
		
		public function StarlingDragObject(dragSource:DisplayObject, tex:Texture, rescale:Boolean, lockCenter:Boolean, offset:Point, bounds:Rectangle, onStage:Boolean) {
			if (!_internalCall) {
				Error.throwError(IllegalOperationError, 2012, "StarlingDragObject");
			}
			super();
			if(onStage) {
				addChild(new Image(tex));
			}
			if(!rescale) {
				StarlingDisplayUtils.setscale(this, dragSource.scaleX, dragSource.scaleY);
			}
			_dragSource = dragSource;
			_rescale = rescale;
			_lockCenter = lockCenter;
			_offset = offset;
			_bounds = bounds;
			_onStage = onStage;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		public function advanceTime(time:Number):void {
			if (!super.visible) {
				return;
			}
			if(Validate.isNotNull(_dragSource.parent)) {
				_dragSource.getTransformationMatrix(Starling.current.stage, _TMP_MATRIX);
			}
			if(!_rescale) {
				StarlingDisplayUtils.setscale(this, dragSource.scaleX, dragSource.scaleY);
			}
			var mouseX:Number = Starling.current.nativeOverlay.mouseX;
			var mouseY:Number = Starling.current.nativeOverlay.mouseY;
			if(_lockCenter) {
				mouseX -= width  >> 1;
				mouseY -= height >> 1;
			} else {
				mouseX -= _offset.x * _TMP_MATRIX.a;
				mouseY -= _offset.y * _TMP_MATRIX.d;
			}
			if (Validate.isNotNull(_bounds)) {
				mouseX = Math.min(Math.max(_bounds.left, mouseX), _bounds.right);
				mouseY = Math.min(Math.max(_bounds.top, mouseY), _bounds.bottom);
			}
			_PREV_POS.setTo(super.x, super.y);
			super.x = mouseX;
			super.y = mouseY;
			if(!_onStage) {
				_TMP_POINT.setTo(super.x, super.y);
				_dragSource.parent.globalToLocal(_TMP_POINT, _TMP_POINT);
				_dragSource.x = _TMP_POINT.x;
				_dragSource.y = _TMP_POINT.y;
			}
		}
		
		private var _rescale:Boolean;
		private var _dragSource:DisplayObject;
		private var _lockCenter:Boolean;
		private var _offset:Point;
		private var _bounds:Rectangle;
		private var _onStage:Boolean;
		
		private function onAddedToStage(event:Event):void {
			advanceTime(0);
			Starling.juggler.add(this);
		}
		
		private function onRemovedFromStage(event:Event):void {
			Starling.juggler.remove(this);
			removeChildren(0, -1, true);
		}
		
		public function get dragSource():DisplayObject {
			return _dragSource;
		}
		
		public function get lockCenter():Boolean {
			return _lockCenter;
		}
		
		public function set lockCenter(value:Boolean):void {
			if (value === _lockCenter) {
				return;
			}
			_lockCenter = value;
			advanceTime(0);
		}
		
		public function get rescale():Boolean {
			return _rescale;
		}
		
		public function set rescale(value:Boolean):void {
			_rescale = value;
		}
		
		public function get prevPosition():Point {
			return _PREV_POS;
		}
		
		public override function set x(value:Number):void {
			throw new IllegalOperationError();
		}
		
		public override function set y(value:Number):void {
			throw new IllegalOperationError();
		}
		
		[Deprecated(message="свойство не используется")]
		public override function get parent():DisplayObjectContainer {
			return null;
		}
		
		$internal function get $parent():DisplayObjectContainer {
			return super.parent;
		}
		
		[Deprecated(message="свойство не используется")]
		public override function get stage():Stage {
			return null;
		}
		
		[Deprecated(message="свойство не используется")]
		public override function get visible():Boolean {
			return true;
		}
		
		public override function set visible(value:Boolean):void {
			throw new IllegalOperationError();
		}
		
	}
}