package slavara.as3.core.enums {
	
	/**
	 * @author SlavaRa
	 */
	public class BaseEnum {
		
		public function BaseEnum(name:String){
			super();
			_name = name;
		}
		
		public function toString():String {
			return _name;
		}
		
		private var _name:String;
		
	}
}
