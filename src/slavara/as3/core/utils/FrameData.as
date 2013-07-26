package slavara.as3.core.utils {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * @author SlavaRa
	 */
	public class FrameData {
		
		public function FrameData() {
			super();
		}
		
		public function toString():String {
			return "[FrameData"
			+ "\n" + " rect=" + rect
			+ "\n" + " bitmapData=" + bitmapData
			+ "\n" + " scaleFactor=" + scaleFactor
			+ "\n" + "]";
		}
		
		public var rect:Rectangle;
		public var bitmapData:BitmapData;
		public var scaleFactor:int;
		
	}

}