package ui
{
	import data.DataManager;
	import data.DataMovie;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class MovieCard extends Sprite implements IUIElement
	{
		private var titleDisplay:DisplayMovieTitle;
		private var clock:DisplayClock;
		
		public var dataMovie:DataMovie;
		
		public function MovieCard()
		{
			dataMovie = new DataMovie();
			
			titleDisplay = new DisplayMovieTitle();
			addChild(titleDisplay);
			
			clock = new DisplayClock(onTimeFinish);
			clock.y = 180;
			addChild(clock);
		}
		
		public function onTimeFinish():void
		{
			
		}
		
		public function start():void
		{
		}
		
		public function getRandomMovie():void
		{
			clock.restart();
			DataManager.getInstance().getRandomMovie(dataManager_onGetRandomMovie);
		}
		
		
		private function dataManager_onGetRandomMovie(movieRecord:*=null):void
		{
			dataMovie.deserialize( movieRecord[0] );
			titleDisplay.title_es = dataMovie.title_es;
			titleDisplay.title_en = dataMovie.title_en;
			titleDisplay.year = "(" + dataMovie.year +")";
			titleDisplay.tagline = dataMovie.tagline;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			clock.disposeTemporarily();
			titleDisplay.disposeTemporarily();
		}
	}
}