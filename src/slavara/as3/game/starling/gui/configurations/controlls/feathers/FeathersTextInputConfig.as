package slavara.as3.game.starling.gui.configurations.controlls.feathers {
	import feathers.textures.Scale3Textures;
	import slavara.as3.game.starling.gui.configurations.controlls.StarlingTextFieldConfig;
	import starling.display.DisplayObject;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersTextInputConfig extends StarlingTextFieldConfig {
		
		public function FeathersTextInputConfig() {
			super();
			paddingTop = 0;
			paddingRight = 0;
			paddingBottom = 0;
			paddingLeft = 0;
			restrict = "";
			maxChars = -1
		}
		
		public var paddingTop:Number;
		public var paddingRight:Number;
		public var paddingBottom:Number;
		public var paddingLeft:Number;
		public var restrict:String;
		public var maxChars:int;
		public var scale3texBackgroundTex:Scale3Textures;//TODO: переделать на конфиг
	}
}