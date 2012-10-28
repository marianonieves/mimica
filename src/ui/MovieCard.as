package ui
{
	import data.DataManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class MovieCard extends Sprite implements IUIElement
	{
		private var titleDisplay:DisplayMovieTitle;
		private var clock:DisplayClock;
		
		public function MovieCard()
		{
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
			titleDisplay.text = movieRecord[0].title_es + "\n" + movieRecord[0].title_en + "\n (" + movieRecord[0].year +")";
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}