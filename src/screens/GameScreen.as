package screens
{	
	import data.DataManager;
	
	import navigation.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import ui.Background;
	import ui.MenuGame;
	import ui.DisplayTeams;
	import ui.Logo;
	import ui.MovieCard;
	
	public class GameScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		
		private var movieCard:MovieCard;
		private var displayTeams:DisplayTeams;
		private var displayGameMenu:MenuGame;
		
		public var dataManager:DataManager = DataManager.getInstance();

		public function GameScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("GameCanvas screen onAddedToStage");
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function initialize(params:Object=null):void
		{
			// add Background
			background = new Background();
			addChild(background);
			
			// add Logo
			logo = new Logo();
			addChild(logo);			

			// add Teams
			displayTeams = new DisplayTeams();
			displayTeams.y = 80;
			addChild(displayTeams);

			// add MovieCard
			movieCard = new MovieCard();
			movieCard.y = 80;
			addChild(movieCard);
			
			// add GameMenu
			displayGameMenu = new MenuGame();
			displayGameMenu.y = 340;
			displayGameMenu.onAction = displayGameMenu_onAction;
			addChild(displayGameMenu);
			
			dataManager.initialize(dataManager_onInitialize);

			this.visible = true;
		}
		
		public function displayGameMenu_onAction(action:String=""):void
		{
			switch(action)
			{
				case displayGameMenu.ACTION_GET_RANDOM_MOVIE:
				{
					movieCard.getRandomMovie();
					break;
				}					
				default:
				{
					trace("[#ERROR#] displayGameMenu_onAction, NO ACTION")
					break;
				}
			}
			
		}
		
		private function dataManager_onInitialize():void
		{
			gameStart();
		}
		
		
		private function gameStart():void
		{
			movieCard.start();
		}
			
						
		public function disposeTemporarily():void
		{
			this.visible = false;
			logo.disposeTemporarily();
			background.disposeTemporarily();
			displayTeams.disposeTemporarily();
			movieCard.disposeTemporarily();
			displayGameMenu.disposeTemporarily();			
		}
		
	}
}