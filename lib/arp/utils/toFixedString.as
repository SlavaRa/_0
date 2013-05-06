package arp.utils {
	/**
	 * 
	 * Утилитка для формирования строки из инта
	 * дополняет нулями вначало до указанного кол-ва знаков
	 * @param	str
	 * @param	num
	 * @return
	 */
	public function toFixedString(str: String, num: int):String {
		while (str.length < num)
			str = "0" + str;
		
		return str;
	}
}