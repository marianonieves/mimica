package screens
{
	import com.greensock.TweenLite;
	
	import embeds.LocalizatedTexts;
	
	import navigation.NavigationEvent;
	import navigation.NavigationManager;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.Logo;
	import ui.MenuWelcome;
	
	import utils.Utils;
	
	public class WelcomeScreen extends Sprite implements IScreen
	{
		private var background:Background;		
		private var logo:Logo;
		private var menu:MenuWelcome;
		
		public function WelcomeScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("welcome screen onAddedToStage");
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
			
			// add Menu
			menu = new MenuWelcome();
			menu.x = 80;
			menu.y = 100;
			menu.onAction = menu_onAction;
			addChild(menu);
	
			this.visible = true;
		}

		public function menu_onAction(action:String=""):void
		{
			trace("menu_onAction:",action);					
			switch (action)
			{
				case NavigationManager.ACTION_NAVIGATE_PLAY:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
					break;
				case NavigationManager.ACTION_NAVIGATE_TEAMS:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "teams",gameId:"new"}, true));
					break;
				case NavigationManager.ACTION_NAVIGATE_GESTURES:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "gestures"}, true));
					break;
				case NavigationManager.ACTION_NAVIGATE_RULES:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "rules"}, true));
					break;
				case NavigationManager.ACTION_NAVIGATE_SETTINGS:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "settings"}, true));
					break;
				default:
				{
					trace("[#ERROR#] displayGameMenu_onAction, NO ACTION")
					break;
				}
			}			
			
		}
		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			background.disposeTemporarily();
			logo.disposeTemporarily();
			menu.disposeTemporarily();
		}
		
	}
}