package slavara.as3.core.utils {
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public class MathUtils {
		
		
		public static function clamp(value:Number, min:Number, max:Number):Number {
			if(value < min) {
				return min;
			}
			if(value > max) {
				return max;
			}
			return value;
		}
		
		public function MathUtils() {
			super();
			if (Object(this).constructor === MathUtils) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}