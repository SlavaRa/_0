package slavara.as3.core.utils {
	import flash.display.BitmapData;
	
	/**
	 * @author SlavaRa
	 */
	public class FrameData {
		
		public function FrameData(x:int, y:int, bitmapData:BitmapData) {
			super();
			this.x = x;
			this.y = y;
			this.bitmapData = bitmapData;
		}
		
		public var x:int;
		public var y:int;
		public var bitmapData:BitmapData;
		
	}

}