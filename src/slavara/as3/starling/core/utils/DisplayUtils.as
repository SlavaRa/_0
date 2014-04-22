package slavara.as3.starling.core.utils {
	import flash.utils.getQualifiedClassName;
	import starling.display.DisplayObject;
	
	/**
	 * @author SlavaRa
	 */
	public class DisplayUtils {
		
		[Inline]
		public static function centerXY(target:DisplayObject, by:DisplayObject):DisplayObject {
			if(target != null && by != null) {
				centerX(target, by);
				centerY(target, by);
			}
			return target;
		}
		
		[Inline]
		public static function centerX(target:DisplayObject, by:DisplayObject):DisplayObject {
			if(target != null && by != null) {
				target.x = (by.width - target.width) >> 1;
			}
			return target;
		}
		
		[Inline]
		public static function centerY(target:DisplayObject, by:DisplayObject):DisplayObject {
			if(target != null && by != null) {
				target.y = (by.height - target.height) >> 1;
			}
			return target;
		}
		
		[Inline]
		public static function setPos(object:DisplayObject, x:Number, y:Number):void {
			if(object != null) {
				object.x = x;
				object.y = y;
			}
		}
		
		public function DisplayUtils() {
			super();
			throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
		}
	}
}