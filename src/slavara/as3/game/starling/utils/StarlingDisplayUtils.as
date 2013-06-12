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
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(enum, "enum");
			}
			
			return container.getChildByName(enum.toString());
		}
		
		public static function getContainerByEnum(container:DisplayObjectContainer, enum:BaseEnum):DisplayObjectContainer {
			return getChildByEnum(container, enum) as DisplayObjectContainer;
		}
		
		public static function getTextFieldByEnum(container:DisplayObjectContainer, enum:BaseEnum):TextField {
			return getChildByEnum(container, enum) as TextField;
		}
		
		public static function getChildByPath(container:DisplayObjectContainer, path:Vector.<BaseEnum>):DisplayObject {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(path, "path");
			}
			
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
		
		public static function getChildrenWithAnchor(container:DisplayObjectContainer, anchor:BaseEnum, fixed:Boolean = true):Vector.<DisplayObject> {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(anchor, "anchor");
			}
			
			const children:Vector.<DisplayObject> = new <DisplayObject>[];
			const anchorString:String = anchor.toString().toLowerCase();
			for(var i:int = 0; i < container.numChildren; i++) {
				const child:DisplayObject = container.getChildAt(i);
				if(Validate.stringIsNullOrEmpty(child.name)) {
					continue;
				}
				if(child.name.toLowerCase().indexOf(anchorString) != -1) {
					children.push(child);
				}
			}
			children.fixed = fixed;
			return children;
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
		
		public static function resize(target:DisplayObject, width:Number, height:Number, allowEnlarge:Boolean = false):void {
			var ratioX:Number = width / target.width;
			var ratioY:Number = height / target.height;
			if (ratioX <= ratioY) {
				if ((ratioX < 1) || allowEnlarge) {
					target.width = width;
					target.scaleY = target.scaleX;
				}
			} else {
				if ((ratioY < 1) || allowEnlarge) {
					target.height = height;
					target.scaleX = target.scaleY;
				}
			}
		}
		
		public function StarlingDisplayUtils() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === StarlingDisplayUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}