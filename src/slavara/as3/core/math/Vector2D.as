package slavara.as3.core.math {
	import slavara.as3.core.utils.RuntimeError;
	/**
	 * @author SlavaRa
	 */
	public class Vector2D {
		// NAMESPACES --------------------------------------------------------------------------/
		// CLASS VARIABLES ---------------------------------------------------------------------/
		// CLASS PROPERTIES --------------------------------------------------------------------/
		// CLASS METHODS -----------------------------------------------------------------------/
		// CONSTRUCTOR -------------------------------------------------------------------------/
		
		public function Vector2D(x:Number = 0, y:Number = 0) {
			super();
			this._x = x;
			this._y = y;
		}
		
		// OVERRIDEN PROPERTIES ----------------------------------------------------------------/
		// OVERRIDEN METHODS -------------------------------------------------------------------/
		// IMPLEMENTED METHODS -----------------------------------------------------------------/
		// PUBLIC PROPERTIES -------------------------------------------------------------------/
		// PUBLIC METHODS ----------------------------------------------------------------------/
		
		public function getResultOfMultiplying(m:Matrix2D, resultVector:Vector2D = null):void {
			RuntimeError.objectIsNull(m, "Matrix2D");
			if (!resultVector) {
				resultVector = new Vector2D();
			}
			resultVector.x = this._x * m.m11 + this._y * m.m21 + m.m31;
			resultVector.y = this._x * m.m12 + this._y * m.m22 + m.m32;
		}
		
		// PROTECTED PROPERTIES ----------------------------------------------------------------/
		// PROTECTED METHODS -------------------------------------------------------------------/
		// PRIVATE PROPERTIES ------------------------------------------------------------------/
		
		private var _x:Number;
		private var _y:Number;
		
		// PRIVATE METHODS ---------------------------------------------------------------------/
		// EVENT HANDLERS ----------------------------------------------------------------------/
		// ACCESSORS ---------------------------------------------------------------------------/
		
		public function get x():Number {
			return this._x;
		}
		
		public function set x(value:Number):void {
			if (value === this._x){
				return;
			}
			this._x = value;
		}
		
		public function get y():Number {
			return this._y;
		}
		
		public function set y(value:Number):void {
			if (value === this._y){
				return;
			}
			this._y = value;
		}
		
		// DEPRECATED --------------------------------------------------------------------------/
	}

}