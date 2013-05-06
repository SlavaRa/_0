package arp.remote {
	import flash.geom.Rectangle;

	[RemoteClass (alias="arp.remote.IntRect")]
	public class IntRect {
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		
		public static function fromRectangle(rect:Rectangle):IntRect {
			return new IntRect(rect.x, rect.y, rect.width, rect.height);
		}
		
		public function IntRect(x: int = 0, y: int = 0, width: int = 0, height: int = 0) {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function toRectangle():Rectangle {
			return new Rectangle(x, y, width, height);
		}
		
		
	}
}
