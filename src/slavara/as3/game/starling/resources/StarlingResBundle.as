package slavara.as3.game.starling.resources {
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Validate;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	[Exclude(kind = "method", name = "getClass")]
	[Exclude(kind = "method", name = "getDisplayObject")]
	[Exclude(kind = "method", name = "getByteArray")]
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingResBundle extends BaseResBundle {
		
		protected static const NAME_2_ATLAS:Dictionary = new Dictionary(false);
		protected static const NAME_2_CONFIG:Dictionary = new Dictionary(false);
		
		private var _NAME_2_TEXTURE_ATLAS:Dictionary;
		private var _NAME_2_ATLAS_XML:Dictionary;
		
		public function StarlingResBundle(name:BaseEnum, assetHash:Dictionary) {
			_NAME_2_TEXTURE_ATLAS = new Dictionary();
			_NAME_2_ATLAS_XML = new Dictionary();
			super(name, assetHash);
		}
		
		public override function getTexture(name:BaseEnum):Texture{
			if (Validate.isNull(_NAME_2_TEXTURE_ATLAS[name2AtlasAndConfig])) {
				_NAME_2_TEXTURE_ATLAS[name2AtlasAndConfig] = new TextureAtlas(getAtlasTex(name2AtlasAndConfig), getXML(name2AtlasAndConfig));
			}
			return TextureAtlas(_NAME_2_TEXTURE_ATLAS[name2AtlasAndConfig]).getTexture(name.toString());
		}
		
		public function hasAtlas(name:BaseEnum):Boolean {
			return Validate.isNotNull(NAME_2_ATLAS[name]);
		}
		
		public function hasConfig(name:BaseEnum):Boolean {
			return Validate.isNotNull(NAME_2_CONFIG[name]);
		}
		
		public function getXML(name:BaseEnum):XML {
			if (!hasConfig(name)) {
				return null;
			}
			if (!(name in _NAME_2_ATLAS_XML)) {
				_NAME_2_ATLAS_XML[name] = XML(new NAME_2_RESOURCE[NAME_2_CONFIG[name]]())
			}
			return XML(_NAME_2_ATLAS_XML[name]);
		}
		
		public function getAtlasTex(name:BaseEnum):Texture {
			Assert.isNull(name, "name");
			if (!hasAtlas(name) && !hasConfig(name)) {
				return null;
			}
			return Texture.fromBitmapData(getBitmapData(NAME_2_ATLAS[name]), true);
		}
		
		public function getTextureAtlas(name:BaseEnum):TextureAtlas {
			Assert.isNull(name, "name");
			if (!hasAtlas(name) && !hasConfig(name)) {
				return null;
			}
			if (!(name in _NAME_2_TEXTURE_ATLAS)) {
				_NAME_2_TEXTURE_ATLAS[name] = new TextureAtlas(getAtlasTex(name), getXML(name))
			}
			return TextureAtlas(_NAME_2_TEXTURE_ATLAS[name]);
		}
		
		protected var name2AtlasAndConfig:BaseEnum;
		
		[Deprecated(message="метод запреден")]
		public override function getClass(uri:BaseEnum):Class {
			return null
		}
		
		[Deprecated(message="метод запрещен")]
		public override function getDisplayObject(uri:BaseEnum):DisplayObject {
			return null;
		}
		
		[Deprecated(message="метод запрещен")]
		public override function getByteArray(uri:BaseEnum):ByteArray {
			return null;
		}
	}
}