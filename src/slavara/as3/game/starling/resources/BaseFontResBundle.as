package slavara.as3.game.starling.resources {
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import starling.text.BitmapFont;
	
	/**
	 * @author SlavaRa
	 */
	public class BaseFontResBundle  extends StarlingResBundle {
		
		protected static const NAME_2_SOURCE:Dictionary = new Dictionary(false);
		protected static const NAME_2_FONT:Dictionary = new Dictionary(false);
		
		public function BaseFontResBundle(name:BaseEnum) {
			super(name, NAME_2_SOURCE)
			if (Object(this).constructor === BaseFontResBundle) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
		public function getBitmapFont(name:BaseEnum):BitmapFont {
			Assert.isNull(name, "name");
			if (!(hasAtlas(name) && hasConfig(name))) {
				return null;
			}
			if (name in NAME_2_FONT) {
				return BitmapFont(NAME_2_FONT[name]);
			}
			return NAME_2_FONT[name] = new BitmapFont(getAtlasTex(name), getXML(name));
		}
	}

}