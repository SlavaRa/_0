package slavara.as3.game.starling.gui.builders {
	import flash.display.BitmapData;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingImageConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingQuadConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingTextFieldConfig;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.managers.ResourceManager;
	import slavara.as3.game.starling.utils.TexUtils;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingGUIBuilder extends GUIBuilder {
		
		public static function createImageFromARP(texUri:BaseEnum):Image {
			return createImage(ResourceManager.getTextureFromARPBundle(texUri));
		}
		
		public static function createImageFromBitmapData(bitmapData:BitmapData):Image {
			return createImage(TexUtils.getFromBitmapData(bitmapData));
		}
		
		public static function createImage(tex:Texture):Image {
			return new Image(tex);
		}
		
		public static function buildTextField(config:StarlingTextFieldConfig):DisplayObject {
			const textField:TextField = new TextField(config.width, config.height, config.text, config.fontName, config.fontSize, config.color, config.bold);
			textField.hAlign = config.hAlign;
			return textField;
		}
		
		public static function buildQuad(config:StarlingQuadConfig):DisplayObject {
			return new Quad(config.width, config.height, config.color, config.premultipliedAlpha);
		}
		
		public function StarlingGUIBuilder(config:GUIConfig) { super(config); }
		
		public override function build():void {
			product = DisplayObjectContainer(preBuildItem(config));
			fill(product, config.children);
			super.build();
		}
		
		protected override function preBuildItem(config:GUIConfig):DisplayObject {
			var item:DisplayObject;
			switch (Object(config).constructor) {
				case StarlingTextFieldConfig:
					item = buildTextField(StarlingTextFieldConfig(config));
					break;
				case StarlingImageConfig:
					item = StarlingGUIBuilder.createImageFromARP(config.tex);
					break;
				case StarlingQuadConfig:
					item = buildQuad(StarlingQuadConfig(config));
					break;
				default: item = super.preBuildItem(config);
			}
			return postBuildItem(item, config);
		}
		
	}
}