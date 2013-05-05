package slavara.as3.core.events {
	import slavara.as3.core.commands.Command;
	import flash.events.Event;
	
	/**
	 * @author СлаваRa
	 */
	public class CommandEvent extends Event {
		
		public function CommandEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, command:Command = null){
			super(type, bubbles, cancelable);
			this.command = command;
		}
		
		public override function clone():Event {
			return new CommandEvent(type, bubbles, cancelable, command);
		}
		
		public override function toString():String {
			return formatToString("CommandEvent", "type", "bubbles", "cancelable", "command");
		}
		
		public var command:Command;
		
		public function call(client:Object, $namespace:Namespace = null):* {
			return command.call(client, $namespace);
		}
		
	}
}