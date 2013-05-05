package slavara.as3.core.commands {
	import flash.events.IEventDispatcher;
	import flash.net.DynamicPropertyOutput;
	
	/**
	 * @author СлаваRa
	 */
	public interface ICommandDispatcher extends IEventDispatcher {
		function addCommandListener(commandName:String, listener:Function, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeCommandListener(commandName:String, listener:Function):void;
		function removeCommandListeners():void;
		function hasCommandListener(commandName:String):Boolean;
		function dispatchCommand(command:Command):Boolean;
	}
}