package ui
{
	import data.DataManager;
	import data.MovieData;
	
	import embeds.LocalizatedTexts;
	
	import screens.GameScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class DisplayMovieCard extends Sprite implements IUIElement
	{
		private var titleDisplay:DisplayMovieTitle;
		private var clock:DisplayClock;
		
		public var dataMovie:MovieData;
		public var onAction:Function;
		
		private var menuMovieCard:MenuMovieCard;
		
		public function DisplayMovieCard()
		{
			dataMovie = new MovieData();
			
			titleDisplay = new DisplayMovieTitle();
			addChild(titleDisplay);
			
			clock = new DisplayClock(onTimeFinish);
			clock.y = 140;
			addChild(clock);
			
			menuMovieCard = new MenuMovieCard();
			menuMovieCard.y = 240;
			menuMovieCard.onAction = menuGameCard_onAction;
			menuMovieCard.setMode(MenuMovieCard.MODE_CHOOSE_MOVIE);
			addChild(menuMovieCard);
		}	
		
		public function menuGameCard_onAction(action:String):void
		{
			switch(action)
			{
				case GameScreen.ACTION_OTHER:
				{
					getRandomMovie();
					break;
				}					
				case GameScreen.ACTION_READY:
				{
					onReady();
					break;
				}
				case GameScreen.ACTION_PAUSE:
				{
					onPause();
					break;
				}					
				case GameScreen.ACTION_RESUME:
				{
					onResume();
					break;
				}					
				case GameScreen.ACTION_PENALTY:
				{
					onPenalty();
					break;
				}					
				case GameScreen.ACTION_GUESSED:
				{
					onGuessed();
					break;
				}					
				default:
				{
					trace("[#ERROR#] DisplayMovieCard.menuMovieCard_onAction(), NO ACTION");
					break;
				}
			}
		}
		
		public function onPenalty():void
		{
			trace("[LOG] DisplayMoviecard.onPenalty()");
			clock.removeTimeInSecs( 10 );
		}
				
		public function onPause():void
		{
			trace("[LOG] DisplayMoviecard.onPause()");
			
			menuMovieCard.setMode(MenuMovieCard.MODE_PAUSED);
			
			titleDisplay.hide();
			clock.pause();
		}
		
		public function onResume():void
		{
			trace("[LOG] DisplayMoviecard.onResume()");
			
			menuMovieCard.setMode(MenuMovieCard.MODE_GUESSING);
			
			titleDisplay.show();
			clock.start();
		}
		
		public function onGuessed():void
		{
			trace("[LOG] DisplayMoviecard.onGuessed()");
			onAction( GameScreen.ACTION_TURN_WON );
		}
		
		public function onTimeFinish():void
		{
			trace("[LOG] DisplayMoviecard.onTimeFinish()");
			onAction( GameScreen.ACTION_TURN_LOST );
		}
		
		public function onReady():void
		{
			trace("[LOG] DisplayMoviecard.onReady()");
			clock.restart();
			menuMovieCard.setMode(MenuMovieCard.MODE_GUESSING);
		}
		
		public function getRandomMovie():void
		{
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
			menuMovieCard.disposeTemporarily();
		}
	}
}