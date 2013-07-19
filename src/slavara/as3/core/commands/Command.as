package slavara.as3.core.commands{
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.Collection;
	/**
	 * @author СлаваRa
	 */
	public dynamic class Command extends Array{
		
		public function Command(name:String, args:Array = null) {
			CONFIG::debug
			{
				Assert.stringIsNullOrEmpty(name, "name");
			}
			
			super();
			this.name = name;
			if (Collection.nonEmpty(args)) {
				push.apply(this, args);
			}
		}
		
		public var name:String;
		
		public function call(client:Object, $namespace:Namespace = null):* {
			return client[new QName($namespace || '', name)].apply(client, this);
		}
		
		public function clone():Command {
			return new Command(name, this);
		}
		
	}
}