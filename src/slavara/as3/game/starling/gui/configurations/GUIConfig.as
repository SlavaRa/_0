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
			skewX = 0;
			skewY = 0;
			rotation = 0;
			children = new Vector.<GUIConfig>(0, true);
			touchable = true;
			visible = true;
			useHandCursor = false;
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
		public var skewX:Number;
		public var skewY:Number;
		public var tex:BaseEnum;
		public var children:Vector.<GUIConfig>;
		public var touchable:Boolean;
		public var visible:Boolean;
		public var useHandCursor:Boolean;
		
		public function setName(enum:BaseEnum):void {
			name = enum.toString();
		}
		
		public function setxy(x:Number = 0, y:Number = 0):void {
			this.x = x;
			this.y = y;
		}
		
		public function setsize(width:Number = 0, height:Number = 0):void {
			this.width = width;
			this.height = height;
		}
		
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