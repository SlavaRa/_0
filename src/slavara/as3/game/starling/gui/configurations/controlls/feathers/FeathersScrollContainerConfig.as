package slavara.as3.game.starling.gui.configurations.controlls.feathers {

	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersScrollContainerConfig extends GUIConfig {
		
		public function FeathersScrollContainerConfig() {
			super();
			verticalScrollPosition = 0;
			horizontalScrollPosition = 0;
			scrollerProperties = new ScrollerProperties();
			scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
		}
		
		public var horizontalLayout:HorizontalLayout;
		public var verticalLayout:VerticalLayout;
		public var verticalScrollPosition:int;
		public var horizontalScrollPosition:int;
		public var scrollerProperties:ScrollerProperties;
		
	}
}

class ScrollerProperties {
	public function ScrollerProperties() {
		super();
	}
	public var horizontalScrollPolicy:String;
	public var verticalScrollPolicy:String;
}