package slavara.as3.core.utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.Texture;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author SlavaRa
	 */
	public final class DestroyUtils {
		// NAMESPACES --------------------------------------------------------------------------/
		// CLASS VARIABLES ---------------------------------------------------------------------/
		// CLASS PROPERTIES --------------------------------------------------------------------/
		// CLASS METHODS -----------------------------------------------------------------------/
		
		public static function destroy(object:*, safeMode:Boolean = true):void {
			if (object) {
				
				if (object is IDestroyable) {
					IDestroyable(object).destroy();
				}
				
				if (object is Program3D) {
					Program3D(object).dispose();
				} else if (object is Texture) {
					Texture(object).dispose();
				} else if (object is Context3D) {
					Context3D(object).dispose();
				} else if (object is DisplayObject) {
					destroyDisplayObject(DisplayObject(object), safeMode);
				} else if (object is Graphics) {
					Graphics(object).clear();
				} else if (object is BitmapData && !safeMode) {
					BitmapData(object).dispose();
				} else if (object is ByteArray && !safeMode) {
					ByteArray(object).clear();
				}
			}
		}
		
		private static function destroyDisplayObject(child:DisplayObject, safeMode:Boolean = true):void {
			if (!child || child.stage) {
				return;
			}
			
			if (child is Shape) {
				Shape(child).graphics.clear();
			} else if (child is Bitmap) {
				const bitmap:Bitmap = Bitmap(child);
				if (bitmap.bitmapData) {
					if (!safeMode) {
						bitmap.bitmapData.dispose();
					}
					bitmap.bitmapData = null;
				}
			} else if (child is TextField) {
				const textField:TextField = TextField(child);
				textField.text = "";
				textField.styleSheet = null;
			} else if (child is DisplayObjectContainer) {
				if (child is Loader) {
					const loader:Loader = Loader(child);
					try {
						child = loader.content;
					} catch (e:*) {
					}
					if (child) {
						DestroyUtils.destroy(loader.content, safeMode);
					}
					try {
						loader.close();
					} catch (e:*) {
					}
					try {
						loader.unloadAndStop(false);
					} catch (e:*) {
					}
				} else {
					const container:DisplayObjectContainer = DisplayObjectContainer(child);
					if (container) {
						if (container is MovieClip) {
							MovieClip(container).stop();
						}
						if (container is Sprite) {
							const sprite:Sprite = Sprite(container);
							sprite.graphics.clear();
							sprite.hitArea = null;
						}
					}
				}
			}
			child.mask = null;
		}
		
		// CONSTRUCTOR -------------------------------------------------------------------------/
		
		[ExcludeClass]
		public function DestroyUtils() {
			super();
			if ((this as Object).constructor === DestroyUtils) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
		// OVERRIDEN PROPERTIES ----------------------------------------------------------------/
		// OVERRIDEN METHODS -------------------------------------------------------------------/
		// IMPLEMENTED METHODS -----------------------------------------------------------------/
		// PUBLIC PROPERTIES -------------------------------------------------------------------/
		// PUBLIC METHODS ----------------------------------------------------------------------/
		// PROTECTED PROPERTIES ----------------------------------------------------------------/
		// PROTECTED METHODS -------------------------------------------------------------------/
		// PRIVATE PROPERTIES ------------------------------------------------------------------/
		// PRIVATE METHODS ---------------------------------------------------------------------/
		// EVENT HANDLERS ----------------------------------------------------------------------/
		// ACCESSORS ---------------------------------------------------------------------------/
		// DEPRECATED --------------------------------------------------------------------------/
	}
}