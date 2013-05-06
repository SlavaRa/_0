package slavara.as3.game.starling.enums.gui {
	
	/**
	 * @author SlavaRa
	 */
	public class WindowsEnum {
		
		public static const VALUES:Vector.<WindowsEnum> = new <WindowsEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const TITLE:WindowsEnum = new WindowsEnum("title");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function WindowsEnum(num:String){
			super(num);
			if (_lockUp) {
				throw new Error("This enum vas already initialized");
			}
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}
import slavara.as3.game.starling.enums.gui.WindowsEnum;
WindowsEnum.lockUp();