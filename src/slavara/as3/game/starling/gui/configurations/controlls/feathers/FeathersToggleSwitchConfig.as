package slavara.as3.game.starling.gui.configurations.controlls.feathers {
	import feathers.controls.ToggleSwitch;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersToggleSwitchConfig extends GUIConfig {
		
		public function FeathersToggleSwitchConfig() {
			super();
			defaultLabelProperties = new DefaultLabelProperties();
			isSelected = true;
			labelAlign = ToggleSwitch.LABEL_ALIGN_MIDDLE;
			onText = "";
			offText = "";
			useHandCursor = true;
			touchable = true;
			trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
		}
		
		public var defaultLabelProperties:DefaultLabelProperties;
		public var isSelected:Boolean;
		/**
		 * TODO: заменить на
		 * toggle.thumbProperties.defaultSkin = new Image( upTexture );
		 * toggle.thumbProperties.downSkin = new Image( downTexture );
		 */
		public var thumbFactory:Function/*():Button*/;
		public var onTrackFactory:Function/*():Button*/;
		public var labelAlign:String;
		public var onText:String;
		public var offText:String;
		public var useHandCursor:Boolean;
		public var trackLayoutMode:String;
		
		public function setAlign(enum:BaseEnum):void {
			labelAlign = enum.toString();
		}
	}

}

import feathers.text.BitmapFontTextFormat;
class DefaultLabelProperties {
	public function DefaultLabelProperties() {
		super();
	}
	public var textFormat:BitmapFontTextFormat;
}