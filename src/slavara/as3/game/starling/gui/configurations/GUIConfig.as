package slavara.as3.game.starling.gui.configurations {
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.resources.IResBundle;
	import starling.filters.BlurFilter;
	
	/**
	 * @author SlavaRa
	 */
	public class GUIConfig {
		
		public function GUIConfig() {
			super();
			
			name = "";
			x = 0;
			y = 0;
			width = 0;
			height = 0;
			scaleX = 1;
			scaleY = 1;
			alpha = 1;
			rotation = 0;
			children = new Vector.<GUIConfig>(0, true);
		}
		
		public var bundle:IResBundle;
		public var name:String;
		public var x:Number;
		public var y:Number;
		public var width:int;
		public var height:int;
		public var scaleX:Number;
		public var scaleY:Number;
		public var alpha:Number;
		public var filter:BlurFilter;
		public var rotation:Number;
		public var tex:BaseEnum;
		public var children:Vector.<GUIConfig>;
		
		public function addChildren(children:Vector.<GUIConfig>):void {
			this.children.fixed = false;
			this.children = this.children.concat(children);
			this.children.fixed = true;
		}
		
		public function addChild(child:GUIConfig):void {
			children.fixed = false;
			children.push(child);
			children.fixed = true;
		}
	}
}