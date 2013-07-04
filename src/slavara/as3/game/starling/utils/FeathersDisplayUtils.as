package slavara.as3.game.starling.utils {
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.enums.BaseEnum;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersDisplayUtils {
		
		//{ region aliases
		
		/**
		 * @see slavara.as3.game.starling.utils.FeathersDisplayUtils.getButtonByEnum
		 */
		public static function getBTNby(container:DisplayObjectContainer, enum:BaseEnum):Button {
			return getButtonByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.FeathersDisplayUtils.getTextInputByEnum
		 */
		public static function getTIby(container:DisplayObjectContainer, enum:BaseEnum):TextInput {
			return getTextInputByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.FeathersDisplayUtils.getScrollContainerByEnum
		 */
		public static function getSCby(container:DisplayObjectContainer, enum:BaseEnum):ScrollContainer {
			return getScrollContainerByEnum(container, enum);
		}
		
		/**
		 * @see slavara.as3.game.starling.utils.FeathersDisplayUtils.getListByEnum
		 */
		public static function getLby(container:DisplayObjectContainer, enum:BaseEnum):List {
			return getScrollContainerByEnum(container, enum);
		}
		
		//} endregion
		
		public static function getButtonByEnum(container:DisplayObjectContainer, enum:BaseEnum):Button {
			return StarlingDisplayUtils.getDOby(container, enum) as Button;
		}
		
		public static function getTextInputByEnum(container:DisplayObjectContainer, enum:BaseEnum):TextInput {
			return StarlingDisplayUtils.getDOby(container, enum) as TextInput;
		}
		
		public static function getScrollContainerByEnum(container:DisplayObjectContainer, enum:BaseEnum):ScrollContainer {
			return StarlingDisplayUtils.getDOby(container, enum) as ScrollContainer;
		}
		
		public static function getListByEnum(container:DisplayObjectContainer, enum:BaseEnum):List {
			return StarlingDisplayUtils.getDOby(container, enum) as List;
		}
		
		public function FeathersDisplayUtils() {
			super();
			CONFIG::debug
			{
				if ((this as Object).constructor === FeathersDisplayUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}