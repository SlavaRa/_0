package slavara.as3.core.math {
	import slavara.as3.core.utils.RuntimeError;
	
	/**
	 * @author SlavaRa
	 * @author skype: slava_er.a.
	 * 
	 * taken as a basis implementing Volgogradetzzz'a
	 */
	public class Matrix2D {
		// NAMESPACES --------------------------------------------------------------------------/
		// CLASS VARIABLES ---------------------------------------------------------------------/
		// CLASS PROPERTIES --------------------------------------------------------------------/
		// CLASS METHODS -----------------------------------------------------------------------/
		// CONSTRUCTOR -------------------------------------------------------------------------/
		
		public function Matrix2D(	m11:Number = 1, m12:Number = 0, m13:Number = 0,
									m21:Number = 0, m22:Number = 1, m23:Number = 0,
									m31:Number = 0, m32:Number = 0, m33:Number = 1) {
			super();
			this.m11 = m11, this.m12 = m12, this.m13 = m13;
			this.m21 = m21, this.m22 = m22, this.m23 = m23;
			this.m31 = m31, this.m32 = m32, this.m33 = m33;
		}
		
		// OVERRIDEN PROPERTIES ----------------------------------------------------------------/
		// OVERRIDEN METHODS -------------------------------------------------------------------/
		// IMPLEMENTED METHODS -----------------------------------------------------------------/
		// PUBLIC PROPERTIES -------------------------------------------------------------------/
		
		public var m11:Number, m12:Number, m13:Number;
		public var m21:Number, m22:Number, m23:Number;
		public var m31:Number, m32:Number, m33:Number;
		
		// PUBLIC METHODS ----------------------------------------------------------------------/
		
		public function clone():Matrix2D {
			return new Matrix2D(this.m11, this.m12, this.m13,
								this.m21, this.m22, this.m23,
								this.m31, this.m32, this.m33);
		}
		
		public function copyFrom(m:Matrix2D):void {
			this.m11 = m.m11, this.m12 = m.m12, this.m13 = m.m13;
			this.m21 = m.m21, this.m22 = m.m22, this.m23 = m.m23;
			this.m31 = m.m31, this.m32 = m.m32, this.m33 = m.m33;
		}
		
		public function copyTo(m:Matrix2D):void {
			m.m11 = this.m11, m.m12 = this.m12, m.m13 = this.m13;
			m.m21 = this.m21, m.m22 = this.m22, m.m23 = this.m23;
			m.m31 = this.m31, m.m32 = this.m32, m.m33 = this.m33;
		}
		
		public function identity():void {
			this.m11 = 1, this.m12 = 0, this.m13 = 0;
			this.m21 = 0, this.m22 = 1, this.m23 = 0;
			this.m31 = 0, this.m32 = 0, this.m33 = 1;
		}
		
		public function rotate(angle:Number):void {
			const sin:Number = Math.sin(angle);
			const cos:Number = Math.cos(angle);
			
			this.m11 = cos, this.m12 = -sin;
			this.m21 = sin, this.m22 =  cos;
		}
		
		public function scale(sx:Number, sy:Number):void {
			this.m11 = sx;
			this.m12 = sy;
		}
		
		public function toString():String {
			return 	'[' + this.m11 + ', ' + this.m12 + ', ' + this.m13 + ',\n' +
					' ' + this.m21 + ', ' + this.m22 + ', ' + this.m23 + ',\n' +
					' ' + this.m31 + ', ' + this.m32 + ', ' + this.m33 + ']';
		}
		
		public function translate(tx:Number, ty:Number):void {
			this.m31 = tx;
			this.m32 = ty;
		}
		
		public function multiplyByMatrix(m:Matrix2D):void {
			RuntimeError.objectIsNull(m, "matrix");
			
			const temp11:Number = m11*m.m11 + m12*m.m21 + m13*m.m31;
			const temp12:Number = m11*m.m12 + m12*m.m22 + m13*m.m32;
			const temp13:Number = m11*m.m13 + m12*m.m23 + m13*m.m33;
			const temp21:Number = m21*m.m11 + m22*m.m21 + m23*m.m31;
			const temp22:Number = m21*m.m12 + m22*m.m22 + m23*m.m32;
			const temp23:Number = m21*m.m13 + m22*m.m23 + m23*m.m33;
			const temp31:Number = m31*m.m11 + m32*m.m21 + m33*m.m31;
			const temp32:Number = m31*m.m12 + m32*m.m22 + m33*m.m32;
			const temp33:Number = m31*m.m13 + m32*m.m23 + m33*m.m33;
			
			m11 = temp11, m12 = temp12, m13 = temp13;
			m21 = temp21, m22 = temp22, m23 = temp23;
			m31 = temp31, m32 = temp32, m33 = temp33;
		}
		
		public function getResultOfMultiplying(m:Matrix2D, resultMatrix:Matrix2D = null):Matrix2D {
			RuntimeError.objectIsNull(m, "matrix");
			
			if (!resultMatrix) {
				resultMatrix = new Matrix2D();
			}
			
			resultMatrix.m11 = m11*m.m11 + m12*m.m21 + m13*m.m31;
			resultMatrix.m12 = m11*m.m12 + m12*m.m22 + m13*m.m32;
			resultMatrix.m13 = m11*m.m13 + m12*m.m23 + m13*m.m33;
			resultMatrix.m21 = m21*m.m11 + m22*m.m21 + m23*m.m31;
			resultMatrix.m22 = m21*m.m12 + m22*m.m22 + m23*m.m32;
			resultMatrix.m23 = m21*m.m13 + m22*m.m23 + m23*m.m33;
			resultMatrix.m31 = m31*m.m11 + m32*m.m21 + m33*m.m31;
			resultMatrix.m32 = m31*m.m12 + m32*m.m22 + m33*m.m32;
			resultMatrix.m33 = m31*m.m13 + m32*m.m23 + m33*m.m33;
			
			return resultMatrix;
		}
		
		// PROTECTED PROPERTIES ----------------------------------------------------------------/
		// PROTECTED METHODS -------------------------------------------------------------------/
		// PRIVATE PROPERTIES ------------------------------------------------------------------/
		// PRIVATE METHODS ---------------------------------------------------------------------/
		// EVENT HANDLERS ----------------------------------------------------------------------/
		// ACCESSORS ---------------------------------------------------------------------------/
		// DEPRECATED PROPERTIES ---------------------------------------------------------------/
	}
}