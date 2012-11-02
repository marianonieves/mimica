package screens
{
	import data.DataManager;
	
	import embeds.LocalizatedTexts;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.DisplayTextSlides;
	import ui.Logo;
	
	import utils.Settings;

	public class SettingsScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		private var displayTextArea:DisplayTextSlides;
		private var btnLang:Button;
		public const ACTION_CHANGE_LANG:String="ACTION_CHANGE_LANG";
		
		public function SettingsScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Credits screen onAddedToStage");
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
			
			displayTextArea = new DisplayTextSlides();
			displayTextArea.y = 80;
			addChild(displayTextArea);
			
			btnLang = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_SETTINGS"));
			btnLang.name = ACTION_CHANGE_LANG;
			btnLang.x = 0;
			btnLang.y = 200;
			btnLang.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnLang);
			
			
			setText();
			
			this.visible = true;			
		}

		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			toggleLang();
		}	
				
		private function toggleLang():void
		{
			if( Settings.lang == Settings.LANG_EN ) 
				Settings.lang = Settings.LANG_ES;
			else 
				Settings.lang = Settings.LANG_EN;
			
			trace("toggleLang to " + Settings.lang);
			
			DataManager.getInstance().updateSettings(DataManager_onUpdateSettings);
		}
		
		private function DataManager_onUpdateSettings(action:String=""):void
		{
			setText();
		}
		
		private function setText():void
		{
			displayTextArea.text = Settings.lang;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			btnLang.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			
			background.disposeTemporarily();
			logo.disposeTemporarily();
			displayTextArea.disposeTemporarily();
			
		}
		
	}
}