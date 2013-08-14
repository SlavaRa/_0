package slavara.air.utils {
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.utils.StringUtils;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.utils.StarlingDestroyUtils;
	
	/**
	 * @author SlavaRa
	 */
	public class Filesystem {
		
		public static function readAndLoadSWFFile(file:File, allowCodeImport:Boolean, onLoadCallback:Function/*(fileName:String, applicationDomain:ApplicationDomain):void*/, destroyLoader:Boolean = true, onLoadParams:Array = null):void {
			const bytes:ByteArray = new ByteArray();
			const reader:FileStream = new FileStream();
			reader.open(file, FileMode.READ);
			reader.readBytes(bytes);
			reader.close();
			
			const context:LoaderContext = new LoaderContext();
			context.allowCodeImport = allowCodeImport;
			
			const loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
				const loaderInfo:LoaderInfo = loader.contentLoaderInfo;
				loaderInfo.removeEventListener(Event.COMPLETE, arguments.callee);
				bytes.clear();
				if(Validate.isNotNull(onLoadParams)) {
					onLoadCallback(file.nativePath, loaderInfo.applicationDomain, onLoadParams);
				} else {
					onLoadCallback(file.nativePath, loaderInfo.applicationDomain);
				}
				if(destroyLoader) {
					StarlingDestroyUtils.destroy(loader);
				}
			});
			loader.loadBytes(bytes, context);
		}
		
		public static function readUTFFile(file:File):String {
			const bytes:ByteArray = new ByteArray();
			const reader:FileStream = new FileStream();
			reader.open(file, FileMode.READ);
			reader.readBytes(bytes);
			reader.close();
			bytes.position = 0;
			const config:String = bytes.readUTFBytes(bytes.length).replace(/\\/g, "/");
			bytes.clear();
			return config;
		}
		
		public static function writeUTFFile(string:String, file:File):void {
			const bytes:ByteArray = new ByteArray();
			const writer:FileStream = new FileStream();
			bytes.position = 0;
			bytes.writeUTFBytes(string);
			writer.open(file, FileMode.WRITE);
			writer.writeBytes(bytes);
			writer.close();
			bytes.clear();
		}
		
		public static function getFiles(path:String, result:Array/*of File*/, anchor:String, recursive:Boolean = false):Array/*of File*/{
			if(Validate.stringIsNullOrEmpty(path)){
				return result;
			}
			if(Validate.isNull(result)) {
				result = [];
			}
			const directoryListing:Array/*of File*/ = new File(path).getDirectoryListing();
			const files:Array/*of File*/ = directoryListing.filter(function(item:File, index:int, list:Array/*of File*/):Boolean {
				return StringUtils.exists(anchor, item.name);
			});
			const directories:Array/*of File*/ = directoryListing.filter(function(item:File, index:int, list:Array/*of File*/):Boolean {
				return Validate.isNull(item.extension);
			});
			result = result.concat(files);
			if(recursive) {
				for each(var item:File in directories) {
					const tmpResult:Array/*of File*/ = getFiles(item.nativePath, [], anchor, recursive);
					result = result.concat(tmpResult);
				}
			}
			return result;
		}
		
		public function Filesystem() {
			super();
			if (Object(this).constructor === Filesystem) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}