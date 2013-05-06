package arp.remote {
	import flash.net.registerClassAlias;

	public function registerARP():void {
		registerClassAlias("arp.remote.ARPBundle", ARPBundle);
		registerClassAlias("arp.remote.ARPResource", ARPResource);
		registerClassAlias("arp.remote.IntPoint", IntPoint);
		registerClassAlias("arp.remote.IntSize", IntSize);
		registerClassAlias("arp.remote.IntRect", IntRect);
		registerClassAlias("arp.remote.Region", Region);
	}
}
