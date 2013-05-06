package slavara.as3.core.utils {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class DisplayUtils {
		
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
		public static function clearContainer(container:DisplayObjectContainer, destroyChildren:Boolean = true, safeMode:Boolean = true):void {
			if (Validate.isNull(container)) {
				return;
			}
			
			if (destroyChildren) {
				while (container.numChildren !== 0) {
					DestroyUtils.destroy(container.removeChildAt(0), safeMode);
				}
			} else {
				container.removeChildren();
			}
		}
		
		public function DisplayUtils() {
			super();
			if (Object(this).constructor === DisplayUtils) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}