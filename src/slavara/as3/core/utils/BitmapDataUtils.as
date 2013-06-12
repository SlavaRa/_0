package slavara.as3.core.utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class BitmapDataUtils {
		
		public static function getBitmapDataFrame(source:IBitmapDrawable):BitmapData {
			if (source is BitmapData) {
				return BitmapData(source).clone();
			} else if (source is Bitmap) {
				return Bitmap(source).bitmapData.clone();
			} else if (source is DisplayObject) {
				const target:DisplayObject = DisplayObject(source);
				const rect:Rectangle = target.getBounds(target);
				if (!rect.isEmpty()) {
					const bitmapData:BitmapData = new BitmapData(Math.ceil(rect.width + 2), Math.ceil(rect.height + 2), true, 0x000000);
					bitmapData.draw(target, new Matrix(1, 0, 0, 1, Math.ceil(-rect.x + 1), Math.ceil(-rect.y + 1)));
					return bitmapData;
				}
			}
			Error.throwError(ArgumentError, 0);
			return null;
		}
		
		public function BitmapDataUtils() {
			super();
			CONFIG::debug
			{
				if (Object(this).constructor === BitmapDataUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
	
	}

}