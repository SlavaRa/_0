package slavara.as3.core.utils {
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class Validate {
		
		[Inline]
		public static function isNull(object:Object):Boolean {
			return object === null;
		}
		
		[Inline]
		public static function isNotNull(object:Object):Boolean {
			return !isNull(object);
		}
		
		[Inline]
		public static function stringIsNullOrEmpty(string:String):Boolean {
			return isNull(string) || (string.length === 0);
		}
		
		[Inline]
		public static function stringIsNotEmpty(string:String):Boolean {
			if(isNull(string)) {
				return false;
			}
			return string.length > 0;
		}
		
		[Inline]
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
		
		[Inline]
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
		
		public function Validate() {
			super();
			if ((this as Object).constructor === Validate) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
	}
}