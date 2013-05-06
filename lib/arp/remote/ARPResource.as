package arp.remote {
	[RemoteClass  (alias="arp.remote.ARPResource")]
	public class ARPResource {	
		public var regions:Vector.<Region>;
		public var name:String;
		public var scale:Number;
		public var size:IntSize = new IntSize();
		
		public function ARPResource(name:String = null, regions:Vector.<Region> = null, scale:Number = 1) {
			super();
			this.name = name;
			this.regions = regions || new Vector.<Region>();
			this.scale = scale;
		}
		
		public function isAnimated():Boolean {
			return (regions.length > 1)
		}
	}
}
