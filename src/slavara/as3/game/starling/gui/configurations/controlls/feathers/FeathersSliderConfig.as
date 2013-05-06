package slavara.as3.game.starling.gui.configurations.controlls.feathers {

	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersSliderConfig extends GUIConfig {
		
		public function FeathersSliderConfig() {
			super();
			minimum = 0;
			maximum = 100;
			value = 50;
			step = 1;
			showThumb = true;
		}
		
		public var minimum:int;
		public var maximum:int;
		public var value:int;
		public var step:int;
		public var showThumb:Boolean;
		public var texThumbDefaultSkin:BaseEnum;
		public var texThumbDownSkin:BaseEnum;
		public var texThumbHoverSkin:BaseEnum;
		public var texMinimumTrackDefaultSkin:BaseEnum;
		public var texMinimumTrackDownSkin:BaseEnum;
		public var texMaximumTrackDefaultSkin:BaseEnum;
		public var texMaximumTrackDownSkin:BaseEnum;
		
	}
}