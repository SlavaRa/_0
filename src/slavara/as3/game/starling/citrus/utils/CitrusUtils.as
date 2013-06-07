package slavara.as3.game.starling.citrus.utils {
	
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.simple.Sensor;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.game.starling.gui.builders.StarlingGUIBuilder;
	
	/**
	 * @author SlavaRa
	 */
	public class CitrusUtils {
		
		public static function getObjectByEnum(container:StarlingState, enum:BaseEnum):CitrusObject {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(enum, "enum");
			}
			
			return container.getObjectByName(enum.toString())
		}
		
		public static function getObjectsByEnum(container:StarlingState, enum:BaseEnum):Vector.<CitrusObject> {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(enum, "enum");
			}
			
			return container.getObjectsByName(enum.toString());
		}
		
		public static function getSpriteByEnum(container:StarlingState, enum:BaseEnum):CitrusSprite {
			return getObjectByEnum(container, enum) as CitrusSprite;
		}
		
		public static function getSensorByEnum(container:StarlingState, enum:BaseEnum):Sensor {
			return getObjectByEnum(container, enum) as Sensor;
		}
		
		public static function getSensorsWhitAnchor(container:StarlingState, anchor:BaseEnum):Vector.<Sensor> {
			CONFIG::debug
			{
				Assert.isNull(container, "container");
				Assert.isNull(anchor, "enum");
			}
			
			const objects:Vector.<CitrusObject> = container.getObjectsByType(Sensor);
			const sensors:Vector.<Sensor> = new <Sensor>[];
			for each (var item:CitrusObject in objects) {
				if (item.name.indexOf(anchor.toString()) !== -1) {
					sensors.push(item);
				}
			}
			return sensors;
		}
		
		public static function setViewAsImage(container:StarlingState, containerEnum:BaseEnum, viewEnum:BaseEnum):void {
			getSpriteByEnum(container, containerEnum).view = StarlingGUIBuilder.createImageFromARP(viewEnum);
		}
		
		public function CitrusUtils() {
			super();
			
			CONFIG::debug
			{
				if (Object(this).constructor === CitrusUtils) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
		}
		
	}
}