package slavara.as3.game.starling.utils {
	
	import flash.display.BitmapData;
	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.text.TextField;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDisplayUtils {
		
		//{ region aliases
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getChildByEnum
		 */
		public static function getDOby(container:DisplayObjectContainer, enum:BaseEnum):DisplayObject {
			return getChildByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getContainerByEnum
		 */
		public static function getDOCby(container:DisplayObjectContainer, enum:BaseEnum):DisplayObjectContainer {
			return getContainerByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getTextFieldByEnum
		 */
		public static function getTFby(container:DisplayObjectContainer, enum:BaseEnum):TextField {
			return getTextFieldByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getMovieClipByEnum
		 */
		public static function getMCby(container:DisplayObjectContainer, enum:BaseEnum):MovieClip {
			return getMovieClipByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getImageByEnum
		 */
		public static function getIby(container:DisplayObjectContainer, enum:BaseEnum):Image {
			return getImageByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getQuadByEnum
		 */
		public static function getQby(container:DisplayObjectContainer, enum:BaseEnum):Quad {
			return getQuadByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.StarlingDisplayUtils.getQuadBatchByEnum
		 */
		public static function getQBby(container:DisplayObjectContainer, enum:BaseEnum):QuadBatch {
			return getQuadBatchByEnum(container, enum);
		}
		
		//} endregion aliases
		
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
		
		public static function getMovieClipByEnum(container:DisplayObjectContainer, enum:BaseEnum):MovieClip {
			return getChildByEnum(container, enum) as MovieClip;
		}
		
		public static function getImageByEnum(container:DisplayObjectContainer, enum:BaseEnum):Image {
			return getChildByEnum(container, enum) as Image;
		}
		
		public static function getQuadByEnum(container:DisplayObjectContainer, enum:BaseEnum):Quad {
			return getChildByEnum(container, enum) as Quad;
		}
		
		public static function getQuadBatchByEnum(container:DisplayObjectContainer, enum:BaseEnum):QuadBatch {
			return getChildByEnum(container, enum) as QuadBatch;
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
			if(Validate.isNull(object)) {
				return;
			}
			object.x = x;
			object.y = y;
		}
		
		public static function setscale(object:DisplayObject, scaleX:Number, scaleY:Number):void {
			if(Validate.isNotNull(object)) {
				object.scaleX = scaleX;
				object.scaleY = scaleY;
			}
		}
		
		public static function setsize(target:DisplayObject, width:Number = 0, height:Number = 0):void {
			if (Validate.isNull(target)) {
				return;
			}
			target.width = width;
			target.height = height;
		}
		
		public static function resize(target:DisplayObject, width:Number, height:Number, allowEnlarge:Boolean = false):void {
			if(Validate.isNull(target)){
				return;
			}
			const ratioX:Number = width / target.width;
			const ratioY:Number = height / target.height;
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
		
		public static function getObjectsUnderPoint(point:Point, result:Vector.<DisplayObject> = null):Vector.<DisplayObject> {
			CONFIG::debug
			{
				Assert.isNull(point, "point");
			}
			if(Validate.isNull(result)) {
				result = new <DisplayObject>[];
			}
			Collection.clear(result);
			const nodes:Vector.<DisplayObject> = new <DisplayObject>[Starling.current.stage];
			while(nodes.length > 0) {
				const container:DisplayObjectContainer = nodes.shift() as DisplayObjectContainer;
				if(Validate.isNull(container)){
					continue;
				}
				for(var i:int = 0; i < container.numChildren; i++) {
					const child:DisplayObject = container.getChildAt(i);
					if (child.hitTest(child.globalToLocal(point))) {
						result.push(child);
						if(child is DisplayObjectContainer) {
							nodes.push(child);
						}
					}
				}
			}
			result.fixed = true;
			return result;
		}
		
		public static function target2BitmapData(target:DisplayObject):BitmapData {
			CONFIG::debug
			{
				Assert.isNull(target, "target");
			}
			if (Validate.isNull(target)) {
				return null;
			}
			
			const support:RenderSupport = new RenderSupport();
			const result:BitmapData = new BitmapData(target.width, target.height, true, 0x000000);
			
			Starling.context.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			support.clear();
			support.setOrthographicProjection(0, 0, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
			target.render(support, 1);
			support.finishQuadBatch();
			Starling.context.drawToBitmapData(result);
			support.dispose();
			return result;
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