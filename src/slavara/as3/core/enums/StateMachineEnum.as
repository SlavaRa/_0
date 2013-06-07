package slavara.as3.core.enums {
	
	/**
	 * @author SlavaRa
	 */
	public class StateMachineEnum extends BaseEnum {
		
		public static const VALUES:Vector.<StateMachineEnum> = new <StateMachineEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const CHANGE:StateMachineEnum = new StateMachineEnum("Change");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function StateMachineEnum(num:String) {
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
import slavara.as3.core.enums.StateMachineEnum;
StateMachineEnum.lockUp();