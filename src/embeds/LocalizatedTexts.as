package embeds
{
	public class LocalizatedTexts
	{
		public static const LANG_EN:String = "en";
		public static const LANG_ES:String = "es";
		
		public static var lang:String = LocalizatedTexts.LANG_EN;

		public static var textGesture_en:String="To act out a phrase, one usually starts by indicating what category the phrase is in, and how many words are in the phrase. From then on, the usual procedure is to act out the words one at a time (although not necessarily in the order that they appear in the phrase). In some cases, however, it may make more sense to try to act out the 'entire concept' of the phrase at once.";
		
		public static function getLocalizatedTextByKey(key:String):String
		{
			var keyLang:String = key+"_"+lang;
			var s:String = LocalizatedTexts[keyLang];
			return LocalizatedTexts[key+"_"+lang];
		}
		
	}
}