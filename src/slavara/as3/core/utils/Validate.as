package slavara.as3.core.utils {
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class Validate {
		
		public static function isNull(object:Object):Boolean {
			return object === null;
		}
		
		public static function isNotNull(object:Object):Boolean {
			return !isNull(object);
		}
		
		public static function stringIsNullOrEmpty(string:String):Boolean {
			return isNull(string) || (string.length === 0);
		}
		
		public static function stringIsNotEmpty(string:String):Boolean {
			if(isNull(string)) {
				return false;
			}
			return string.length > 0;
		}
		
		public static function isVector(vector:Object):Boolean {
			if(vector is Vector.<int>) {
				return true;
			}
			if(vector is Vector.<uint>) {
				return true;
			}
			if(vector is Vector.<Number>) {
				return true;
			}
			if(vector is Vector.<String>) {
				return true;
			}
			if(vector is Vector.<*>) {
				return true;
			}
			return false;
		}
		
		public static function isArray(array:Object):Boolean {
			return (array is Array) || (array is ByteArray);
		}
		
		public static function collectionIsNullOrEmpty(collection:Object):Boolean {
			if(isArray(collection) || isVector(collection)) {
				return collection.length === 0;
			} else {
				for (var name:* in collection) {
					if(isNotNull(name)) {
						return false;
					}
				}
			}
			return true;
		}
		
		public static function collectionIsNotEmpty(collection:Object):Boolean {
			if(isArray(collection) || isVector(collection)) {
				return collection.length > 0;
			} else {
				for (var name:* in collection) {
					if(isNotNull(name)) {
						return true;
					}
				}
			}
			return false;
		}
		
		public static function existsInString(pattern:String, string:String, strict:Boolean = true):Boolean {
			if (stringIsNullOrEmpty(pattern)) {
				return false;
			}
			if (stringIsNullOrEmpty(string)) {
				return false;
			}
			if(!strict) {
				string.toLowerCase().indexOf(pattern.toLowerCase()) != -1;
			}
			return string.indexOf(pattern) != -1
		}
		
		public function Validate() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === Validate) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
	}
}