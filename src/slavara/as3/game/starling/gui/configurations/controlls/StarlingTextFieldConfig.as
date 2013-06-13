package slavara.as3.game.starling.gui.configurations.controlls {
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingTextFieldConfig extends GUIConfig {
		
		public function StarlingTextFieldConfig() {
			super();
			fontName = "Verbana";
			fontSize = 12;
			color = 0x000000;
			bold = false;
			hAlign = "left";
			touchable = false;
		}
		
		public var text:String;
		public var fontName:String;
		public var fontSize:Number;
		public var color:uint;
		public var bold:Boolean;
		public var hAlign:String;
		
	}
}