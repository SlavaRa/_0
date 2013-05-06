package slavara.as3.game.starling.gui.builders {
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingImageConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingQuadConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingTextFieldConfig;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.managers.ResourceManager;
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
			return new Image(ResourceManager.getTextureFromARPBundle(texUri));
		}
		
		public function StarlingGUIBuilder(config:GUIConfig) {
			super(config);
		}
		
		public override function build():void {
			product = DisplayObjectContainer(preBuildItem(config));
			fillContainer(product, config.children);
			super.build();
		}
		
		protected override function preBuildItem(config:GUIConfig):DisplayObject {
			var item:DisplayObject;
			switch (Object(config).constructor) {
				case StarlingTextFieldConfig:
					item = getStarlingTextField(StarlingTextFieldConfig(config));
					break;
				case StarlingImageConfig:
					item = StarlingGUIBuilder.createImageFromARP(config.tex);
					break;
				case StarlingQuadConfig:
					item = getStarlingQuad(StarlingQuadConfig(config));
					break;
				default: item = super.preBuildItem(config);
			}
			return postBuildItem(item, config);
		}
		
		private function getStarlingTextField(config:StarlingTextFieldConfig):DisplayObject {
			return new TextField(config.width, config.height, config.text, config.fontName, config.fontSize, config.color, config.bold);
		}
		
		private function getStarlingQuad(config:StarlingQuadConfig):DisplayObject {
			return new Quad(config.width, config.height, config.color, config.premultipliedAlpha);
		}
		
	}
}