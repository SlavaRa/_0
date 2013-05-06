package slavara.as3.game.starling.managers {
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.enums.BaseEnum;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.GUIItem;
	import slavara.as3.game.starling.gui.windows.BaseWindow;
	import slavara.as3.game.starling.utils.StarlingDisplayUtils;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	/**
	 * @author SlavaRa
	 */
	public class WindowsManager {
		
		private static var _instance:WindowsManager;
		private static var _isInitialized:Boolean = true;
		
		public static function get instance():WindowsManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new WindowsManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public function WindowsManager() {
			super();
			if (_isInitialized) {
				throw new Error("Singleton, use WindowsManager.instance");
			}
		}
		
		public function setup(enum2window:Dictionary):WindowsManager {
			Assert.isNull(enum2window, "enum2window");
			if (Validate.isNull(_enum2window)) {
				initialize();
				constructWindows();
			}
			return this;
		}
		
		public function alertIsOpened():Boolean {
			return Validate.isNotNull(_alert);
		}
		
		public function alert(uri:BaseEnum):BaseWindow {
			Assert.isNull(uri, "uri");
			if (canNotOpenWindowOrAlert(uri)) {
				return null;
			}
			
			const alert:BaseWindow = BaseWindow(_enum2window[uri]);
			alert.onClosed.addOnce(onAlertClosed);
			StarlingDisplayUtils.addChildTo(alert.view, _containerAlert);
			_alert = alert.open();
			return _alert;
		}
		
		public function has(uri:BaseEnum):Boolean {
			return Boolean(_enum2window[uri]);
		}
		
		public function show(uri:BaseEnum):BaseWindow {
			Assert.isNull(uri, "uri");
			if (canNotOpenWindowOrAlert(uri)) {
				return null;
			}
			
			const window:BaseWindow = BaseWindow(_enum2window[uri]);
			_queue.push(window);
			close(_openedWindow);
			return window;
		}
		
		public function close(window:BaseWindow):void {
			if (window === _alert) {
				_alert.close();
			} else if (Validate.isNotNull(window)) {
				window.close();
			} else {
				onWindowClosed();
			}
		}
		
		public function closeAll():void {
			if (Validate.isNotNull(_alert)) {
				_alert.close();
			}
			
			_queue.length = 0;
			close(openedWindow);
		}
		
		private var _enum2window:Dictionary;
		private var _containerDialogWindows:DisplayObjectContainer;
		private var _queue:Vector.<BaseWindow>;
		private var _openedWindow:BaseWindow;
		private var _containerAlert:DisplayObjectContainer;
		private var _alert:BaseWindow;
		private var _onWindowOpen:Signal;
		private var _onWindowClosed:Signal;
		
		private function initialize(enum2Window:Dictionary):void {
			_enum2window = enum2window;
			_containerDialogWindows = new Sprite();
			_containerAlert = new Sprite();
			_queue = new <BaseWindow>[];
			_onWindowOpen = new Signal();
			_onWindowClosed = new Signal();
		}
		
		private function constructWindows():void {
			for (var uri:* in _enum2window) {
				GUIItem(_enum2window[uri]).build();
			}
		}
		
		private function onWindowClosed(window:BaseWindow = null):void {
			if (window) {
				Starling.current.juggler.remove(_openedWindow);
				StarlingDisplayUtils.removeChildFrom(window.view, _containerDialogWindows);
			}
			
			_openedWindow = null;
			_onWindowClosed.dispatch();
			
			if (_queue.length === 0) {
				return;
			}
			
			window = _queue.shift();
			window.onClosed.addOnce(onWindowClosed);
			StarlingDisplayUtils.addChildTo(window.view, _containerDialogWindows);
			_openedWindow = window.open();
			_onWindowOpen.dispatch();
			Starling.current.juggler.add(_openedWindow);
		}
		
		private function onAlertClosed(window:BaseWindow):void {
			StarlingDisplayUtils.removeChildFrom(window.view, _containerAlert);
			_alert = null;
		}
		
		private function canNotOpenWindowOrAlert(uri:BaseEnum):Boolean {
			return alertIsOpened() && !has(uri);
		}
		
		public function get openedWindow():BaseWindow {
			return _openedWindow;
		}
		
		public function get onWindowOpen():Signal {
			return _onWindowOpen;
		}
		
		public function get onWindowClosed():Signal {
			return _onWindowClosed;
		}
		
	}
}