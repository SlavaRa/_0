package slavara.air.utils {
	
	import air.update.net.FileDownloader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.utils.StringUtils;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public class Filesystem {
		
		public static function readBinaryFile(file:File, uncompress:String = null, result:ByteArray = null):ByteArray {
			if(Validate.isNull(result)) {
				result = new ByteArray();
			}
			const reader:FileStream = new FileStream();
			reader.open(file, FileMode.READ);
			reader.readBytes(result);
			reader.close();
			result.position = 0;
			if(Validate.stringIsNotEmpty(uncompress)) {
				result.uncompress(uncompress);
			}
			return result;
		}
		
		//NOTE: 
		public static function readUTFFileByPath(path:String):String {
			if(Validate.stringIsNullOrEmpty(path)) {
				return null;
			}
			return readUTFFile(new File(path));
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