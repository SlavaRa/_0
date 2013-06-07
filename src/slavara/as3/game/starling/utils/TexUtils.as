package slavara.as3.game.starling.utils {
	
	import feathers.textures.Scale9Textures;
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