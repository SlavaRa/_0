package slavara.as3.game.starling.gui.configurations.controlls.feathers {
	import feathers.data.HierarchicalCollection;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersGroupedListConfig extends FeathersScrollContainerConfig {
		
		public function FeathersGroupedListConfig() {
			super();
			itemRendererProperties = new ItemRendererProperties();
			dataProvider = new HierarchicalCollection();
			isSelectable = true;
		}
		
		public var headerRendererFunction:Function/*():IGroupedListHeaderOrFooterRenderer*/;
		public var itemRendererProperties:ItemRendererProperties;
		public var itemRendererFactory:Function/*():IGroupedListItemRenderer*/;
		public var dataProvider:HierarchicalCollection;
		public var isSelectable:Boolean;
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