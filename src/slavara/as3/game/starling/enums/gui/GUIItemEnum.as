package slavara.as3.game.starling.enums.gui {
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class GUIItemEnum extends BaseEnum{
		
		public static const VALUES:Vector.<GUIItemEnum> = new <GUIItemEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const CONTAINER:BaseEnum = new GUIItemEnum("Container");
		public static const TEXT_INPUT:BaseEnum = new GUIItemEnum("TextInput");
		public static const SCROLL_CONTAINER:BaseEnum = new GUIItemEnum("ScrollContainer");
		public static const LIST:BaseEnum = new GUIItemEnum("List");
		public static const GROUPED_LIST:BaseEnum = new GUIItemEnum("GroupedList");
		public static const BUTTON_GROUP:BaseEnum = new GUIItemEnum("ButtonGroup");
		public static const BUTTON:BaseEnum = new GUIItemEnum("Button");
		
		private static var _lockUp:Boolean;
		
		public static function lockUp():void {
			_lockUp = true;
			VALUES.fixed = true;
			NAMES.fixed = true;
		}
		
		public function GUIItemEnum(num:String){
			super(num);
			if (_lockUp) {
				throw new Error("This enum vas already initialized");
			}
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}
import slavara.as3.game.starling.enums.gui.GUIItemEnum;
GUIItemEnum.lockUp();