package slavara.as3.core.utils {
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	
	/**
	 * @author SlavaRa
	 */
	public class Collection {
		
		/**
		 * for Object, Dictionary, Array, ByteArray, Vector
		 */
		public static function clear(collection:Object):void {
			if(Validate.isNull(collection)) {
				return;
			}
			
			const isVector:Boolean = Validate.isVector(collection);
			if(Validate.isArray(collection) || isVector) {
				const i:int = collection.length;
				while (i-->0) {
					collection[i] = null;
				}
				if(isVector) {
					collection.fixed = false;
				}
				collection.length = 0;
			}
			for (var key:* in collection) {
				delete collection[key];
			}
		}
		
		/**
		 * for Array, ByteArray, Vector
		 * pos = 0 if p < 0;
		 * pos = collection.length if pos >= collection.length;
		 */
		public static function insert(item:*, pos:int, collection:Object):*{
			Assert.isNull(collection, "collection");
			
			const isVector:Boolean = Validate.isVector(collection);
			if(Validate.isArray(collection) || isVector) {
				const length:int = collection.length;
				if(pos < 0) {
					pos = 0;
				} else if(pos >= length) {
					pos = length;
				}
				if(isVector) {
					collection.fixed = false;
				}
				for (var i:int = length; i > pos; i--) {
					collection[i] = collection[i - 1];
				}
				collection[pos] = item;
			}
			return item;
		}
		
		/**
		 * for Object, Dictionary, Array, ByteArray, Vector
		 */
		public static function remove(item:*, collection:Object):* {
			Assert.isNull(collection, "collection");
			
			const isVector:Boolean = Validate.isVector(collection);
			if(Validate.isArray(collection) || isVector) {
				for (var i:int = 0, found:Boolean, length:int = collection.length; i < length; i++) {
					if (found) {
					   collection[i] = collection[i + 1];
					} else if (collection[i] === item) {
					   found = true;
					   length--;
					   collection[i] = collection[i + 1];
					}
				}
				if(isVector) {
					collection.fixed = false;
				}
				collection.length = length;
			} else if(item in collection) {
				delete collection[item];
			}
			return item;
		}
		
		/**
		 * for Array, ByteArray, Vector
		 * pos = 0 if pos < 0
		 */
		public static function removeAt(pos:int, collection:Object):*{
			Assert.isNull(collection, "collection");
			
			const isVector:Boolean = Validate.isVector(collection);
			if((collection is Array) || (collection is ByteArray) || isVector) {
				if(pos < 0) {
					pos = 0;
				}
				const item:* = collection[pos];
				for (var i:int = pos, length:int = collection.length - 1; i < length; i++) {
					collection[i] = collection[i + 1];
				}
				if(isVector) {
					collection.fixed = false;
				}
				collection.length = length;
				return item;
			}
			return null;
		}
		
		/**
		 * for Object, Dictionary, Array, Vector
		 */
		[Inline]
		public static function exists(item:*, collection:Object):Boolean {
			Assert.isNull(collection, "collection");
			
			if((collection is Array) || Validate.isVector(collection)) {
				return collection.indexOf(item) !== -1;
			}
			return item in collection;
		}
		
		public static function isEmpty(collection:Object):Boolean {
			if(Validate.isArray(collection) || Validate.isVector(collection)) {
				return collection.length === 0;
			}
			for (var key:* in collection) {
				if(Validate.isNotNull(key)) {
					return false;
				}
			}
			return false;
		}
		
		[Inline]
		public static function isNotEmpty(collection:Object):Boolean {
			return !isEmpty(collection);
		}
		
		/**
		 * for Array || ByteArray || Vector
		 */
		[Inline]
		public static function setLength(collection:Object, length:int):void {
			if(Validate.isArray(collection)) {
				collection.length = length;
			} else if(Validate.isVector(collection)) {
				collection.fixed = false;
				collection.length = length;
			}
		}
		
		public function Collection() {
			super();
			if ((this as Object).constructor === Collection) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}