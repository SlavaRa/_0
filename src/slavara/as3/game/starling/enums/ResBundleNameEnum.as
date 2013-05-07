package slavara.as3.game.starling.enums {
	import slavara.as3.core.enums.BaseEnum;
	
	/**
	 * @author SlavaRa
	 */
	public class ResBundleNameEnum extends BaseEnum {
		
		public static const VALUES:Vector.<ResBundleNameEnum> = new <ResBundleNameEnum>[];
		public static const NAMES:Vector.<String> = new <String>[];
		
		public static const ARP:BaseEnum = new ResBundleNameEnum("arp");
		public static const ARP_LOGOTYPE:BaseEnum = new ResBundleNameEnum("ARPLogo");
		
		public function ResBundleNameEnum(num:String){
			super(num);
			VALUES.push(this);
			NAMES.push(num);
		}
		
	}
}