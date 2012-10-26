package ui
{
	import data.DataManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class MovieCard extends Sprite implements IUIElement
	{
		
		private var randomButton:ButtonCustom;
		private var titleDisplay:DisplayMovieTitle;
		private var clock:DisplayClock;
		
		public function MovieCard()
		{
			
			titleDisplay = new DisplayMovieTitle();
			addChild(titleDisplay);
			
			clock = new DisplayClock();
			clock.y = 180;
			addChild(clock);
			
			randomButton = new ButtonCustom("OTRA");
			randomButton.disable();
			randomButton.y = 280;
			randomButton.onClick = onClick;
			addChild(randomButton);
			
		}
		
		public function start():void
		{
			randomButton.enable();
		}
		
		public function onClick():void
		{
			clock.restart();
			DataManager.getInstance().getRandomMovie(dataManager_onGetRandomMovie);
		}
		
		private function dataManager_onGetRandomMovie(movieRecord:*=null):void
		{
			titleDisplay.text = movieRecord[0].title_es + "\n" + movieRecord[0].title_en + "\n (" + movieRecord[0].year +")";
		}
		
		public function set movieTitle(value:String):void 
		{
			titleDisplay.text = value;
		}		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}