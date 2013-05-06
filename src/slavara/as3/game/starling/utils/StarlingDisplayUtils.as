package slavara.as3.game.starling.utils {
	
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Validate;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDisplayUtils {
		
		public static function addChildTo(child:DisplayObject, container:DisplayObjectContainer):DisplayObject {
			if (Validate.isNull(child)) {
				return null;
			}
			if (Validate.isNull(container)) {
				return null;
			}
			return container.addChild(child);
		}
		
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
		
		public static function getChildByEnum(container:DisplayObjectContainer, enum:BaseEnum):DisplayObject {
			Assert.isNull(container, "container");
			Assert.isNull(enum, "enum");
			return container.getChildByName(enum.toString());
		}
		
		public static function getContainerByEnum(container:DisplayObjectContainer, enum:BaseEnum):DisplayObjectContainer {
			return getChildByEnum(container, enum) as DisplayObjectContainer;
		}
		
		public static function getTextFieldByEnum(container:DisplayObjectContainer, enum:BaseEnum):TextField {
			return getChildByEnum(container, enum) as TextField;
		}
		
		public static function getChildByPath(container:DisplayObjectContainer, path:Vector.<BaseEnum>):DisplayObject {
			Assert.isNull(container, "container");
			Assert.isNull(path, "path");
			const length:int = path.length;
			for (var i:int = 0; i < length; i++) {
				const enum:BaseEnum = path[i];
				if (i < (length - 1)) {
					container = getContainerByEnum((container as DisplayObjectContainer), enum);
				} else {
					return getChildByEnum(container, enum);
				}
			}
			return null;
		}
		
		public static function setxy(object:DisplayObject, x:Number, y:Number):void {
			if(Validate.isNotNull(object)) {
				object.x = x;
				object.y = y;
			}
		}
		
		public static function setscale(object:DisplayObject, scaleX:Number, scaleY:Number):void {
			if(Validate.isNotNull(object)) {
				object.scaleX = scaleX;
				object.scaleY = scaleY;
			}
		}
		
		public static function setsize(target:DisplayObject, width:Number = 0, height:Number = 0):void {
			if (Validate.isNotNull(target)) {
				target.width = width;
				target.height = height;
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