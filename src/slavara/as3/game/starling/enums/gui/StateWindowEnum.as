package slavara.as3.game.starling.enums.gui {
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class StateWindowEnum extends BaseEnum {
		
		public static const VALUES:Vector.<StateWindowEnum> = new <StateWindowEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const OPENING:BaseEnum = new StateWindowEnum("Open");
		public static const OPEN:BaseEnum = new StateWindowEnum("Opening");
		public static const CLOSING:BaseEnum = new StateWindowEnum("Closing");
		public static const CLOSED:BaseEnum = new StateWindowEnum("Closed");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function StateWindowEnum(num:String){
			super(num);
			if (_lockUp) {
				throw new Error("This enum vas already initialized");
			}
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}
import slavara.as3.game.starling.enums.gui.StateWindowEnum;
StateWindowEnum.lockUp();