package slavara.as3.core.utils {
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	
	/**
	 * @author SlavaRa
	 */
	public class StringUtils {
		
		public static function exists(to:String, from:String, strict:Boolean = false):Boolean {
			CONFIG::debug
			{
				Assert.stringIsNullOrEmpty(to);
				Assert.stringIsNullOrEmpty(from);
			}
			if(strict) {
				return	from.indexOf(to) !== -1
			}
			return from.toLowerCase().indexOf(to.toLowerCase()) !== -1;
		}
		
		public function StringUtils() {
			super();
			CONFIG::debug
			{
				if (Object(this).constructor === StringUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}