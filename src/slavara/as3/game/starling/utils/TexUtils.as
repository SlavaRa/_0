package slavara.as3.game.starling.utils {
	
	import feathers.textures.Scale9Textures;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import org.flashdevelop.utils.TraceLevel;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.game.starling.managers.ResourceManager;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.textures.Texture;

	/**
	 * @author SlavaRa
	 */
	public class TexUtils {
		
		private static const _bitmapData2tex:Dictionary = new Dictionary(true);
		
		public static function getFromBundle(bundle:IResBundle, name:BaseEnum):Texture {
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
		
		public static function getFromBitmapData(data:BitmapData, generateMipMaps:Boolean = false, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, cache:Boolean = true):Texture {
			CONFIG::debug
			{
				Assert.isNull(data, "data");
			}
			if(data.width > 2048) {
				trace(TraceLevel.WARNING+":", "TexUtils", "data.width > 2048", data.width);
				return null;
			}
			if(data.height > 2048) {
				trace(TraceLevel.WARNING+":", "TexUtils", "data.height > 2048", data.height);
				return null;
			}
			if(Collection.exists(data, _bitmapData2tex)) {
				return Texture(_bitmapData2tex[data]);
			}
			return _bitmapData2tex[data] = Texture.fromBitmapData(data, generateMipMaps, optimizeForRenderToTexture, scale);
		}
		
		public static function disposeFromBitmapData(data:BitmapData):void {
			if(!Collection.exists(data, _bitmapData2tex)) {
				return;
			}
			Texture(_bitmapData2tex[data]).dispose();
			delete _bitmapData2tex[data];
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