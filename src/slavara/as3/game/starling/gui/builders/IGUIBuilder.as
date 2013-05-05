package slavara.as3.game.starling.gui.builders {
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public interface IGUIBuilder  {
		function build():void;
		function getProduct():DisplayObjectContainer;
	}
}