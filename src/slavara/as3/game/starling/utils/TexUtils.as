package slavara.as3.game.starling.utils {
	
	import feathers.textures.Scale9Textures;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.managers.ResourceManager;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.textures.Texture;

	/**
	 * @author SlavaRa
	 */
	public class TexUtils {
		
		public static function getTextureFromBundle(bundle:IResBundle, name:BaseEnum):Texture {
			CONFIG::debug
			{
				Assert.isNull(bundle, "bundle");
				Assert.isNull(name, "name");
			}
			
			return bundle.getTexture(name);
		}
		
		public static function getScale9Textures(name:BaseEnum, scale9Grid:Rectangle):Scale9Textures {
			CONFIG::debug
			{
				Assert.isNull(name, "name");
				Assert.isNull(scale9Grid, "scale9Grid");
			}
			
			return new Scale9Textures(ResourceManager.getTextureFromARPBundle(name), scale9Grid);
		}
		
		public static function getTextureFromBitmapData(data:BitmapData, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1):Texture {
			CONFIG::debug
			{
				Assert.isNull(data, "data");
			}
			if(data.width > 2048) {
				trace("WARNING data.width > 2048");
				return null;
			}
			if(data.height > 2048) {
				trace("WARNING data.height > 2048");
				return null;
			}
			return Texture.fromBitmapData(data, generateMipMaps, optimizeForRenderToTexture, scale);
		}
		
		public function TexUtils() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === TexUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}