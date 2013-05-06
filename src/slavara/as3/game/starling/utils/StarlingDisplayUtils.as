package slavara.as3.game.starling.utils {
	
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.utils.Validate;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDisplayUtils {
		
		[Inline]
		public static function addChildTo(child:DisplayObject, container:DisplayObjectContainer):DisplayObject {
			if (Validate.isNull(child)) {
				return null;
			}
			if (Validate.isNull(container)) {
				return null;
			}
			return container.addChild(child);
		}
		
		[Inline]
		public static function removeChildFrom(child:DisplayObject, container:DisplayObjectContainer):DisplayObject {
			if(Validate.isNull(child)) {
				return null;
			}
			if(Validate.isNull(child.parent)) {
				return null;
			}
			if(child.parent !== container) {
				return null;
			}
			return container.removeChild(child);
		}
		
		[Inline]
		public static function setxy(object:DisplayObject, x:Number, y:Number):void {
			if(Validate.isNotNull(object)) {
				object.x = x;
				object.y = y;
			}
		}
		
		[Inline]
		public static function setscale(object:DisplayObject, scaleX:Number, scaleY:Number):void {
			if(Validate.isNotNull(object)) {
				object.scaleX = scaleX;
				object.scaleY = scaleY;
			}
		}
		
		public function StarlingDisplayUtils() {
			super();
			if ((this as Object).constructor === StarlingDisplayUtils) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}