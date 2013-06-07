package slavara.as3.game.starling.enums.gui {
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class WindowsEnum extends BaseEnum {
		
		public static const VALUES:Vector.<WindowsEnum> = new <WindowsEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const TITLE:BaseEnum = new WindowsEnum("title");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function WindowsEnum(num:String) {
			super(num);
			
			CONFIG::debug
			{
				if (_lockUp) {
					throw new Error("This enum vas already initialized");
				}
			}
			
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}