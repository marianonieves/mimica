package sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class MusicManager
	{
		
		private static var currentSong:String = "";
		private static var soundControl:SoundChannel = new SoundChannel();
				
		public static function playSong(name:String):void
		{
			if( currentSong != name )
			{
				soundControl.stop();
				soundControl = Assets.getSound(name).play();
			}
		}
		
		public static function stopSong(name:String=""):void
		{
			if( currentSong == name || name=="" )
			{
				soundControl.stop();
			}
		}
		
	}
}