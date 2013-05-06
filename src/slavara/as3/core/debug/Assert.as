package slavara.as3.core.debug {
	
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public final class Assert {
		
		public static function isNull(object:Object, message:String = ""):void {
			if(Validate.isNull(object)) {
				Error.throwError(TypeError, 1009, message);
			}
		}
		
		public static function isNotNull(object:Object, message:String = ""):void {
			if (Validate.isNotNull(object)) {
				Error.throwError(TypeError, 2007, message);
			}
		}
		
		public static function isThis(object:Object, $this:Object, message:String = ""):void {
			if (object === $this) {
				Error.throwError(ArgumentError, 2024, message);
			}
		}
		
		public static function isNotThis(object:Object, $this:Object, message:String = ""):void {
			if (object !== $this) {
				Error.throwError(ArgumentError, 2025, message);
			}
		}
		
		public static function indexLessThanOrMoreThan(index:int, min:int, max:int, message:String = ""):void {
			if (index < min || index > max) {
				Error.throwError(RangeError, 2006, message);
			}
		}
		
		public static function indexLessThan(index:int, min:int, message:String = ""):void {
			if (index < min) {
				Error.throwError(RangeError, 2006, message);
			}
		}
		
		public static function indexMoreThan(index:int, max:int, message:String = ""):void {
			if (index > max) {
				Error.throwError(RangeError, 2006, message);
			}
		}
		
		public static function stringIsNullOrEmpty(string:String, message:String = ""):void {
			if (Validate.stringIsNullOrEmpty(string)) {
				Error.throwError(TypeError, 2007, message);
			}
		}
		
		public function Assert() {
			super();
			if ((this as Object).constructor === Assert) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}