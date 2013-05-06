package slavara.as3.game.starling.gui.configurations.controlls.feathers {

	import flash.geom.Rectangle;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	public class FeathersProgressBarConfig extends GUIConfig {
		
		public function FeathersProgressBarConfig() {
			super();
		}
		
		public var backgroundSkin:BaseEnum;
		public var fillSkin:BaseEnum;
		public var minimum:Number = 0;
		public var maximum:Number = 100;
		public var value:Number = 0;
		public var rect:Rectangle = new Rectangle(10, 0, 134, 10);
		
	}
}