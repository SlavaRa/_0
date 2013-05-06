package slavara.as3.game.starling.gui.configurations.controlls {
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingQuadConfig extends GUIConfig {
		
		public function StarlingQuadConfig() {
			super();
			color = 16777215;
			premultipliedAlpha = true;
		}
		
		public var color:uint;
		public var premultipliedAlpha:Boolean;
		
	}
}