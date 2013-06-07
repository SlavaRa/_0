package slavara.as3.game.starling.utils {
	
	import arp.remote.ARPBundle;
	import arp.remote.ARPResource;
	import arp.remote.Region;
	import arp.utils.toFixedString;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * @author SlavaRa
	 */
	public class ARPUtils {
		
		public static function getTextures(bundle:ARPBundle):Array/*starling.textures.Texture*/{
			const textures:Array/*starling.textures.Texture*/ = [];
			for (var i:int = 0, length:int = bundle.atfTextures.length; i < length; i++) {
				const atf:ByteArray = bundle.atfTextures[i];
				const texture:Texture = Texture.fromAtfData(atf, 1, false);
				textures.push(texture);
				atf.clear();
			}
			return textures;
		}
		
		public static function fillHash(bundle:ARPBundle, name2Resource:Dictionary/*{string:Texture}*/):void {
			
			const textures:Array/*starling.textures.Texture*/ = getTextures(bundle);
			
			for (var name:String in bundle.resources) {
				const resource:ARPResource = bundle.getResource(name);
				if (resource.regions.length) {
					const region:Region = resource.regions[0];
					const atlas:TextureAtlas = new TextureAtlas(textures[region.textureId]);
					const regName:String = resource.name + "_" + toFixedString(String(0), 4);
					atlas.addRegion(regName, region.rect.toRectangle(), new Rectangle(region.pivot.x, region.pivot.y, resource.size.width, resource.size.height));
					name2Resource[name] = atlas.getTexture(regName);
				}
			}
		}
		
		public function ARPUtils() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === ARPUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}