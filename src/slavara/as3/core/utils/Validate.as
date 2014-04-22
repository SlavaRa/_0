package slavara.as3.core.utils {
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class Validate {
		
		[Inline]
		public static function isNull(object:Object):Boolean {
			return object == null;
		}
		
		[Inline]
		public static function isNotNull(object:Object):Boolean {
			return !isNull(object);
		}
		
		public static function stringIsNullOrEmpty(string:String):Boolean {
			return isNull(string) || (string.length == 0);
		}
		
		public static function stringNonEmpty(string:String):Boolean {
			return isNull(string) ? false : string.length > 0;
		}
		
		[Inline]
		public static function isVector(vector:Object):Boolean {
			return (vector is Vector.<int>)
			|| (vector is Vector.<uint>)
			|| (vector is Vector.<Number>)
			|| (vector is Vector.<String>)
			|| (vector is Vector.<*>);
		}
		
		[Inline]
		public static function isArray(array:Object):Boolean {
			return (array is Array) || (array is ByteArray);
		}
		
		[Inline]
		public static function collectionIsNullOrEmpty(collection:Object):Boolean {
			var result:Boolean;
			if(isArray(collection) || isVector(collection)) {
				result = collection.length == 0;
			} else {
				for (var name:* in collection) {
					if(isNotNull(name)) {
						result == false;
						break;
					}
				}
			}
			return result
		}
		
		[Inline]
		public static function collectionIsNotEmpty(collection:Object):Boolean {
			var result:Boolean;
			if(isArray(collection) || isVector(collection)) {
				result = collection.length > 0;
			} else {
				for (var name:* in collection) {
					if(isNotNull(name)) {
						result = true;
						break;
					}
				}
			}
			return result;
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
				if (Object(this).constructor == Validate) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
	}
}