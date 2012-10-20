package screens
{	
	import navigation.NavigationEvent;
		
	import sound.MusicManager;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class GameScreen extends Sprite implements IScreen
	{
		private var background:Image;
		private var mLogo:Button;
		private var selectedGame:DisplayObject;
		
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
			// add content
			background = new Image(Assets.getTexture("Background"));
			addChild(background);
			
			mLogo = new Button(Assets.getAtlasTexture("logo"));
			mLogo.name = "logo";
			mLogo.width = Config.STAGE_WIDTH;
			mLogo.x = int((Config.STAGE_WIDTH - mLogo.width)  / 2);
			mLogo.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			mLogo.y = 10;
			addChild(mLogo);
			
			trace("GameScreen > params.game:" + params.game)
			
			switch( params.game )
			{
				case "game1":
					break;
				case "game2":
					break;
				case "game3":
					break;
				case "game4":
					break;
			}
			
			this.addChild(selectedGame);
			this.visible = true;
		}
		
		public function onButtonTriggered(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			Assets.getSound("Click").play();
			switch (buttonClicked.name)
			{
				case "logo":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
					break;
			}
		}
				
		public function disposeTemporarily():void
		{
			MusicManager.stopSong();
			this.visible = false;
		}
		
	}
}