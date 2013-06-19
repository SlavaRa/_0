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
			useVirtualLayout = false;
			scrollerProperties = new ScrollerProperties();
			scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			scrollerProperties.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			scrollerProperties.interactionMode = Scroller.INTERACTION_MODE_TOUCH;
			touchable = true;
		}
		
		public var horizontalLayout:HorizontalLayout;
		public var verticalLayout:VerticalLayout;
		public var useVirtualLayout:Boolean;
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
	public var interactionMode:String;
	public var scrollBarDisplayMode:String;
	public var horizontalScrollBarFactory:Function;
	public var verticalScrollBarFactory:Function;
}