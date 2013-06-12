package slavara.as3.core.utils {
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public final class Callback {
		
		public static function call(callback:Function, args:Array = null):void {
			if (Validate.isNull(callback)) {
				return;
			}
			if(Validate.collectionIsNotEmpty(args)) {
				callback.apply(null, args);
			} else {
				callback.call();
			}
		}
		
		public function Callback() {
			super();
			CONFIG::debug
			{
				if (Object(this).constructor === Callback) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}