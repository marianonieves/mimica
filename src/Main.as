package 
{
	import navigation.NavigationEvent;
	
	import screens.GameScreen;
	import navigation.NavigationManager;
	import screens.WelcomeScreen;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.TouchEvent;
	import starling.utils.deg2rad;

    public class Main extends Sprite
    {
		private var screenManager:NavigationManager;
        
        public function Main()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function onAddedToStage(event:Event):void
        {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// iPhone 3gs: w:320 , h:480
			// iPhone 4: w:640 , h:960
			// iPad: w:682 , h:1024
			
			// we create the game with a fixed stage size -- only the viewPort is variable.
			stage.stageWidth  = Config.STAGE_WIDTH;
			stage.stageHeight = Config.STAGE_HEIGHT;
			
			// the contentScaleFactor is calculated from stage size and viewport size
			Assets.contentScaleFactor = Starling.current.contentScaleFactor;
			
			// prepare assets
			Assets.prepareSounds();
			Assets.loadBitmapFonts();
			
			// prepare assets
			screenManager = new NavigationManager();
			screenManager.initialize(this);
			this.addEventListener(navigation.NavigationEvent.CHANGE_SCREEN, screenManager.onChangeScreen);
						
			initialize();
        }
        
        private function initialize():void
        {
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
        }
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
    }
}