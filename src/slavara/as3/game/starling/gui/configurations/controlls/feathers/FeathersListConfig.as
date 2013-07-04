package slavara.as3.game.starling.gui.configurations.controlls.feathers {
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersListConfig extends FeathersScrollContainerConfig {
		
		public function FeathersListConfig() {
			super();
			itemRendererProperties = new ItemRendererProperties();
			dataProvider = new ListCollection();
		}
		
		public var itemRendererProperties:ItemRendererProperties;
		public var itemRendererFactory:Function/*():IListItemRenderer*/;
		public var dataProvider:ListCollection;
	}
}

class ItemRendererProperties {
	public function ItemRendererProperties() {
		super();
	}
	
	public var labelField:String = "text";
	public var iconSourceField:String = "thumbnail";
	public var horizontalAlign:String;
	public var verticalAlign:String;
	public var iconPosition:String;
	public var gap:int = 0;
	
}