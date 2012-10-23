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
	
	public class GameScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		private var dataManager:DataManager = DataManager.getInstance();

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
			
			trace("GameScreen > params.game:" + params.game)
			
			dataManager.openDatabaseConnection();
			
			this.visible = true;
		}
		
		private function checkData():void
		{

		}
			
						
		public function disposeTemporarily():void
		{
			this.visible = false;
			logo.disposeTemporarily();
		}
		
	}
}