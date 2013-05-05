package slavara.as3.game.starling.gui.builders {
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import starling.display.DisplayObject;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingGUIBuilder extends GUIBuilder {
		
		public function StarlingGUIBuilder(config:GUIConfig) {
			super(config);
		}
		
		public override function build():void {
			//code here
			super.build();
		}
		
		protected override function preBuildItem(config:GUIConfig):DisplayObject {
			//code here
			return product;
		}
		
		protected override function postBuildItem(config:GUIConfig):DisplayObject {
			//code here
			return super.postBuildItem(config);
		}
		
	}
}