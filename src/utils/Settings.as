package utils
{
	public class Settings
	{
		public static const LANG_EN:String = "EN";
		public static const LANG_ES:String = "ES";
		
		public static var lang:String = Settings.LANG_EN;
		public static var time:int = 300;
		
		public static function formatTime(c:int):String
		{
			var t:String = "";
			var s:int = c%60;
			var m:int = (c-s)/60;
			
			t = ( m < 10 )? "0"+m:m.toString();
			t += ":";
			t += ( s < 10 )? "0"+s:s.toString();
			
			return t;
		}
		
	}
}