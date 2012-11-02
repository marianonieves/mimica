package 
{
	import data.DataManager;
	
	import embeds.LocalizatedTexts;
	
	import navigation.NavigationEvent;
	import navigation.NavigationManager;
	
	import screens.GameScreen;
	import screens.WelcomeScreen;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.TouchEvent;
	import starling.utils.deg2rad;
	
	import utils.Settings;

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
			
			DataManager.getInstance().initialize( getSettings );
        }
		
		private function getSettings():void
		{
			DataManager.getInstance().getSettings( dataManager_onGetSettings );
		}
		
		private function dataManager_onGetSettings(settingsRecord:*=null):void
		{
			trace("Main.dataManager_onGetSettings: ",settingsRecord[0].lang)
			Settings.lang = settingsRecord[0].lang;
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