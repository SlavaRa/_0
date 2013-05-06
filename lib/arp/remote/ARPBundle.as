package arp.remote {

	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;

	[RemoteClass (alias="arp.remote.ARPBundle")]
	public class ARPBundle {
		public var resources:Object  =  {};

		//public var atfTextures:Vector.<ByteArray> = new Vector.<ByteArray>();
		// почему то не сериализуется вектор байтареев
		public var atfTextures:Array = [];
		
		private var _decoded:Boolean = false;
		
		public function ARPBundle() {
			super();
//			registerClassAlias("arp.remote.ARPResource", ARPResource);
//			registerARP();
		}
		
		public function getResource(name:String):ARPResource {
			return resources[name] as ARPResource;
		}
		
		public function hasResource(name:String):Boolean {
			return name in resources;
		}
		
		public function addResource(name:String, res:ARPResource):void {
			resources[name] = res;
		}
		
		public function getResourcesNames():Array {
			var result:Array = [];
			for(var key:String in resources) {
				result.push(key);
			}
			return result;
		}
		
		public function dispose():void {
			for (var i:int = 0; i < atfTextures.length; i++) {
				var bytes:ByteArray = atfTextures[i];
				bytes.clear();
			}
			
			atfTextures = [];
			resources = {};
		}
		
		public function toString():String {
			return "";//ObjectUtil.toString(this);
		}


	}
}
