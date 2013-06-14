package slavara.as3.game.starling.enums.gui 
{
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingTextHAlignEnum extends BaseEnum{
		
		public static const VALUES:Vector.<StarlingTextHAlignEnum> = new <StarlingTextHAlignEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const LEFT:BaseEnum = new StarlingTextHAlignEnum("left");
		public static const CENTER:BaseEnum = new StarlingTextHAlignEnum("center");
		public static const RIGHT:BaseEnum = new StarlingTextHAlignEnum("right");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function StarlingTextHAlignEnum(num:String){
			super(num);
			if (_lockUp) {
				throw new Error("This enum vas already initialized");
			}
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}
import slavara.as3.game.starling.enums.gui.StarlingTextHAlignEnum;
StarlingTextHAlignEnum.lockUp();