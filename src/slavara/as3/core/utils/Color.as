package slavara.as3.core.utils {
	import flash.utils.getQualifiedClassName;
	
	public class Color {
		
		
		public static function extractRFromRGB(color:uint):uint { return color >> 16; }
		
		
		public static function extractGFromRGB(color:uint):uint { return color >> 8 & 0xFF; }
		
		
		public static function extractBFromRGB(color:uint):uint { return color & 0xFF; }
		
		
		public static function extractAFromARGB(color:uint):uint { return color >>> 24; }
		
		
		public static function extractRFromARGB(color:uint):uint { return color >>> 16 & 0xFF; }
		
		
		public static function extractGFromARGB(color:uint):uint { return color >>> 8 & 0xFF; }
		
		
		public static function extractBFromARGB(color:uint):uint { return color & 0xFF; }
		
		
		public static function mergeRBG(r:uint, g:uint, b:uint):uint { return r << 16 | g << 8 | b; }
		
		
		public static function mergeARBG(a:uint, r:uint, g:uint, b:uint):uint { return a << 24 | r << 16 | g << 8 | b }
		
		public function Color() {
			super();
			if ((this as Object).constructor === Color) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}