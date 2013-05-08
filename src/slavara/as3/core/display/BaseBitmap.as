package slavara.as3.core.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * @author СлаваRa
	 */
	public class BaseBitmap extends Bitmap {
		
		public function BaseBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false) {
			super(bitmapData, pixelSnapping, smoothing);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler, false, int.MAX_VALUE, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler, false, int.MAX_VALUE, true);
		}
		
		/**virtual*/
		protected function onAddedToStage():void {
		}
		
		/**virtual*/
		protected function onRemovedFromStage():void {
		}
		
		private var _addedToStage:Boolean = false;
		
		private function onAddedToStageHandler(event:Event):void {
			if(_addedToStage) {
				event.stopImmediatePropagation();
			} else {
				_addedToStage = true;
				onAddedToStage();
			}
		}
		
		private function onRemovedFromStageHandler(event:Event):void {
			_addedToStage = false;
			onRemovedFromStage();
		}
		
	}
}