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
	import ui.Logo;
	import ui.MovieCard;
	
	public class GameScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		
		private var movieCard:MovieCard;
		
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
			
			// add MovieCard
			movieCard = new MovieCard();
			movieCard.y = 80;
			addChild(movieCard);			
			
			dataManager.initialize(dataManager_onInitialize);

			this.visible = true;
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
		}
		
	}
}