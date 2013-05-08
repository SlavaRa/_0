package slavara.air.utils {
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
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
		
		public static function readUTFFile(path:String):String {
			try {
				const file:File = new File(path);
				const reader:FileStream = new FileStream();
				reader.open(file, FileMode.READ);
				const result:String = reader.readUTF();
				reader.close();
				return result;
			} catch (err:Error) {
				trace(err);
			}
			return null;
		}
		
		public function Filesystem() {
			super();
			if (Object(this).constructor === Filesystem) {
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
	}
}