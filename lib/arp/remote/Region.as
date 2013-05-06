package arp.remote {
	/**
	 * Region for starling TextureAtlas#addRegion
	 * @author k.bondarenko
	 */
	[RemoteClass (alias="arp.remote.Region")]
	public class Region {		
		public var rect:IntRect;
		public var textureId:uint;
		public var pivot:IntPoint;
		
		public function Region(rect:IntRect = null, pivot:IntPoint = null, textureId:uint = 0) {
			super();
			this.rect = rect;
			this.pivot =  pivot || new IntPoint();
			this.textureId = textureId;
		}
		
	}
}
