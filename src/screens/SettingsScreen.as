package screens
{
	import data.DataManager;
	import data.MatchData;
	
	import embeds.LocalizatedTexts;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import ui.Background;
	import ui.DisplayTextSlides;
	import ui.Logo;
	
	import utils.Settings;

	public class SettingsScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		
		private var textBackground:Image;
		private var txtLang:TextField;
		
		private var txtTimeLabel:TextField;
		private var txtTimeToPlay:TextField;

		private var btnLang:Button;
		private var btnMoreTime:Button;
		private var btnLessTime:Button;
		private var btnResetMatch:Button;
		
		private var updating:Boolean = false;
		
		public const ACTION_CHANGE_LANG:String="ACTION_CHANGE_LANG";
		public const ACTION_MORE_TIME:String="ACTION_MORE_TIME";
		public const ACTION_LESS_TIME:String="ACTION_LESS_TIME";
		public const ACTION_RESET_MATCH:String="ACTION_RESET_MATCH";
		
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
			
			textBackground = new Image(Assets.getAtlasTexture("backgroundbutton"));
			textBackground.y = 80;
			textBackground.width = 320;
			textBackground.height = 250;
			addChild(textBackground);
			
			// LANGUAGE
			btnLang = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_SETTINGS_CHANGE_LANGUAGE"));
			btnLang.name = ACTION_CHANGE_LANG;
			btnLang.x = 80;
			btnLang.y = 120;
			btnLang.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnLang);
			
			txtLang = new TextField(300,40,"...","Verdana",16);
			txtLang.x = 10;
			txtLang.y = 90;
			addChild(txtLang);
			
			// TIME
			txtTimeLabel = new TextField(300,20,"...","Verdana",12);
			txtTimeLabel.y = 200;
			txtTimeLabel.x = 10;
			txtTimeLabel.text = LocalizatedTexts.getLocalizatedTextByKey("MENU_SETTINGS_MATCH_TIME");
			addChild(txtTimeLabel);			
			
			txtTimeToPlay = new TextField(300,20,"...","Verdana",16);
			txtTimeToPlay.y = 220;
			txtTimeToPlay.x = 10;
			txtTimeToPlay.text = "";
			addChild(txtTimeToPlay);			
			
			btnMoreTime = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_SETTINGS_TIME_MORE"));
			btnMoreTime.name = ACTION_MORE_TIME;
			btnMoreTime.x = 200;
			btnMoreTime.y = 240;
			btnMoreTime.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnMoreTime);
			
			btnLessTime = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_SETTINGS_TIME_LESS"));
			btnLessTime.name = ACTION_LESS_TIME;
			btnLessTime.x = 0;
			btnLessTime.y = 240;
			btnLessTime.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnLessTime);
			
			btnResetMatch = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_SETTINGS_RESET_MATCH"));
			btnResetMatch.name = ACTION_RESET_MATCH;
			btnResetMatch.x = 80;
			btnResetMatch.y = 340;
			btnResetMatch.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnResetMatch);
			
			updateDisplay();
			
			this.visible = true;			
		}

		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			var btnTmp:Button = Button(event.target);
			switch(btnTmp.name)
			{
				case ACTION_CHANGE_LANG:
				{
					toggleLang();
					break;
				}
				case ACTION_LESS_TIME:
				{
					lessTime();
					break;
				}
				case ACTION_MORE_TIME:
				{
					moreTime();
					break;
				}
				case ACTION_RESET_MATCH:
				{
					resetMatchData();
					break;
				}
				default:
				{
					trace("[#ERROR#] SettingsScreen_onButtonTriggered, NO ACTION ", btnTmp.name );
					break;
				}
			}
		}
		
		private function resetMatchData():void
		{
			MatchData.initialize();
		}
		
		private function lessTime():void
		{
			trace("[LOG] SettingsScreen.lessTime " + Settings.time);

			if( Settings.time-60<=0 ) return;
			Settings.time -= 60;
			
			updateSettings();
		}
		
		private function moreTime():void
		{
			trace("[LOG] SettingsScreen.moreTime " + Settings.time);			
			
			if( Settings.time+60>600 ) return;
			Settings.time += 60;
			
			updateSettings();
		}
		
		private function toggleLang():void
		{
			if( Settings.lang == Settings.LANG_EN ) 
				Settings.lang = Settings.LANG_ES;
			else 
				Settings.lang = Settings.LANG_EN;
			
			trace("[LOG] SettingsScreen.toggleLang to " + Settings.lang);
			
			updateSettings();
		}
		
		private function updateSettings():void
		{
			if(!updating)
			{
				DataManager.getInstance().updateSettings(DataManager_onUpdateSettings);
				updating = true;
			} else {
				trace("[#WARNING#] SettingScreen.updateSettings was called two times in a row");
			}
		}
		
		private function DataManager_onUpdateSettings(action:String=""):void
		{
			updateDisplay();
		}
		
		private function updateDisplay():void
		{
			txtLang.text = Settings.lang;
			txtTimeToPlay.text = Settings.formatTime(Settings.time);
			updating = false;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			btnLang.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			btnMoreTime.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			btnLessTime.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			
			background.disposeTemporarily();
			logo.disposeTemporarily();

			
		}
		
	}
}