package slavara.as3.game.starling.managers {
	
	/**
	 * @author SlavaRa
	 */
	public class FontsManager {
		
		private static var _instance:FontsManager;
		private static var _isInitialized:Boolean = true;
		
		public static function get instance():FontsManager {
			if (!_instance) {
				_isInitialized = false;
				_instance = new FontsManager();
				_isInitialized = true;
			}
			return _instance;
		}
		
		public function FontsManager() {
			super();
			
			CONFIG::debug
			{
				if (_isInitialized) {
					throw new Error("Singleton, use FontsManager.instance");
				}
			}
			
		}
		
	}
}