package slavara.as3.game.starling.gui.builders {
	import org.osflash.signals.Signal;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author SlavaRa
	 */
	public interface IGUIBuilder  {
		function build():void;
		function getProduct():DisplayObjectContainer;
		function get onBuild():Signal;
	}
}