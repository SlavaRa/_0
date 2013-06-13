package slavara.as3.game.starling.utils {
	
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.utils.DestroyUtils;
	import slavara.as3.core.utils.Validate;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * @author SlavaRa
	 */
	public class StarlingDestroyUtils {
		
		public static function destroy(target:Object, safeMode:Boolean = true):void {
			if(Validate.isNull(target)){
				return;
			}
			
			if(target is Texture) {
				Texture(target).dispose();
			} else if (target is TextureAtlas) {
				TextureAtlas(target).dispose();
			} else if (target is DisplayObject) {
				DisplayObject(target).dispose();
			} else {
				DestroyUtils.destroy(target, safeMode);
			}
		}
		
		public function StarlingDestroyUtils() {
			super();
			CONFIG::debug
			{
				if (Object(this).constructor === StarlingDestroyUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}