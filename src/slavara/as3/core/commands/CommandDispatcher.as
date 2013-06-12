package slavara.as3.core.commands{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import slavara.as3.core.events.CommandEvent;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author СлаваRa
	 */
	public class CommandDispatcher extends EventDispatcher implements ICommandDispatcher {
		
		public static const PREFIX:String = "command_";
		
		public function CommandDispatcher(target:ICommandDispatcher = null) { 
			super(target);
			_listeners = new Dictionary(true);
		}
		
		/* INTERFACE slavara.as3.core.commands */
		public function addCommandListener(commandName:String, listener:Function, priority:int = 0, useWeakReference:Boolean = false):void {
			const type:String = PREFIX + commandName;
			var commandListener:CommandListener = _listeners[listener] as CommandListener;
			if (Validate.isNull(commandListener)) {
				_listeners[listener] = commandListener = new CommandListener(this, type, listener);
			}
			addEventListener(type, commandListener.handler, false, priority, useWeakReference);
		}
		
		/* INTERFACE slavara.as3.core.commands */
		public function dispatchCommand(command:Command):Boolean {
			return dispatchEvent(new CommandEvent(PREFIX + command.name, false, false, command));
		}
		
		/* INTERFACE slavara.as3.core.commands */
		public function removeCommandListener(commandName:String, listener:Function):void {
			const commandListener:CommandListener = _listeners[listener] as CommandListener;
			if (Validate.isNotNull(commandListener)) {
				delete _listeners[listener];
				removeEventListener(commandListener.type, commandListener.handler);
			}
		}
		
		/* INTERFACE slavara.as3.core.commands */
		public function removeCommandListeners():void {
			for (var listener:* in _listeners) {
				removeCommandListener((CommandListener(_listeners[listener])).type, listener);
			}
		}
		
		/* INTERFACE slavara.as3.core.commands */
		public function hasCommandListener(commandName:String):Boolean {
			return hasEventListener(PREFIX + commandName);
		}
		
		private var _listeners:Dictionary;
	}
}

import slavara.as3.core.commands.CommandDispatcher;
import slavara.as3.core.events.CommandEvent;
class CommandListener {
	
	public function CommandListener(commandDispatcher:CommandDispatcher, type:String, listener:Function) {
		super();
		this.commandDispatcher = commandDispatcher;
		this.type = type;
		this.listener = listener;
	}
	
	public var type:String;
	public var listener:Function;
	public var commandDispatcher:CommandDispatcher;
	
	public function handler(event:CommandEvent):void {
		listener.apply(null, event.command);
	}
}