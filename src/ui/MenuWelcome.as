package ui
{
	import embeds.LocalizatedTexts;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	public class MenuWelcome extends Sprite implements IUIElement 
	{
		
		public var onAction:Function;
		
		private var btnGame1:Button;
		private var btnGame2:Button;
		private var btnGame3:Button;
		private var btnGame4:Button;
		private var btnGame5:Button;
		
		public const ACTION_NAVIGATE_PLAY:String="ACTION_NAVIGATE_PLAY";
		public const ACTION_NAVIGATE_TEAMS:String="ACTION_NAVIGATE_TEAMS";
		public const ACTION_NAVIGATE_GESTURES:String="ACTION_NAVIGATE_GESTURES";
		public const ACTION_NAVIGATE_RULES:String="ACTION_NAVIGATE_RULES";
		public const ACTION_NAVIGATE_CREDITS:String="ACTION_NAVIGATE_CREDITS";

		private var buttonSeparator:int=10;
		
		public function MenuWelcome()
		{

			
			btnGame1 = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_PLAY"));
			btnGame1.name = ACTION_NAVIGATE_PLAY;
			btnGame1.x = 0;
			btnGame1.y = 0;
			btnGame1.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame1);
			
			btnGame2 = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_TEAMS"));
			btnGame2.name = ACTION_NAVIGATE_TEAMS;
			btnGame2.x = 0;
			btnGame2.y = btnGame1.y + btnGame1.height + buttonSeparator;
			btnGame2.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame2);
			
			btnGame3 = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_GESTURES"));
			btnGame3.name = ACTION_NAVIGATE_GESTURES;
			btnGame3.x = 0;
			btnGame3.y = btnGame2.y + btnGame1.height + buttonSeparator;
			btnGame3.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame3);
			
			btnGame4 = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_RULES"));
			btnGame4.name = ACTION_NAVIGATE_RULES;
			btnGame4.x = 0;
			btnGame4.y = btnGame3.y + btnGame1.height + buttonSeparator;
			btnGame4.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame4);
			
			btnGame5 = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_WELCOME_CREDITS"));
			btnGame5.name = ACTION_NAVIGATE_CREDITS;
			btnGame5.x = 0;
			btnGame5.y = btnGame4.y + btnGame1.height + buttonSeparator;
			btnGame5.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame5);			
			
		}

		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			onAction(Button(event.target).name);
		}	
		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (btnGame1.hasEventListener(Event.TRIGGERED)) btnGame1.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame2.hasEventListener(Event.TRIGGERED)) btnGame2.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame3.hasEventListener(Event.TRIGGERED)) btnGame3.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame4.hasEventListener(Event.TRIGGERED)) btnGame4.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
				
	}
}