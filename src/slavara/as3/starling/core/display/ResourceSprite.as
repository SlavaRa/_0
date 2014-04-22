package slavara.as3.starling.core.display {
	import slavara.as3.core.managers.ResourceManager;
	import slavara.as3.core.utils.DestroyUtils;//TODO: replace to slavara.as3.core.starling.DestroyUtils
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author SlavaRa
	 */
	public class ResourceSprite extends Sprite {
		
		public function ResourceSprite() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private var _manager:ResourceManager;//TODO slavara: implement me
		
		protected function getResourceList():Vector.<String> {
			return new Vector.<String>(0, true);
		}
		
		protected function render(event:Event = null):Boolean {
			//TODO slavara: implement me
			return true;
		}
		
		protected function clear(event:Event = null):void {
			_manager = null;
		}
		
		protected function destroyResource(object:*):* {
			return DestroyUtils.destroy(object, true);
		}
		
		private function onAddedToStage(event:Event):void {
			//TODO slavara: implement me
			render(event);
		}
		
		private function onRemovedFromStage(event:Event):void {
			//TODO slavara: implement me
			clear(event);
		}
	}
}