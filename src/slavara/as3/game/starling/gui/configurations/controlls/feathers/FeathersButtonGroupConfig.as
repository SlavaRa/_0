package slavara.as3.game.starling.gui.configurations.controlls.feathers {
	import feathers.data.ListCollection;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersButtonGroupConfig extends GUIConfig {
		
		public function FeathersButtonGroupConfig() {
			super();
			dataProvider = new ListCollection();
			gap = 0;
		}
		
		public var dataProvider:ListCollection;
		public var direction:String;
		public var gap:int;
		public var buttonFactory:Function;/*():Button*/;
		
	}
}