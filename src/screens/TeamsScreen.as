package screens
{
	import data.MatchData;
	
	import navigation.NavigationEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.DisplayTeams;
	import ui.Logo;
	
	public class TeamsScreen extends Sprite implements IScreen
	{
		private var background:Background;		
		private var logo:Logo;
		private var displayTeams:DisplayTeams;
		
		public static const ACTION_CONTINUE:String="ACTION_CONTINUE";
		public static const ACTION_EXIT:String="ACTION_EXIT";
		
		public function TeamsScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("TeamsScreen onAddedToStage");
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
			displayTeams.onAction = onAction;
			addChild(displayTeams);
			
			this.visible = true;
		}

		public function onAction(action:String=""):void
		{
			trace("[LOG] GameScreen.onAction", action);
			switch(action)
			{
				case ACTION_CONTINUE:
				{
					onContinue();
					break;
				}
				case ACTION_EXIT:
				{
					onExit();
					break;
				}
				default:
				{
					trace("[#ERROR#] GameScreen.onAction(), NO ACTION: ", action);
					break;
				}
			}			
		}
		
		public function onContinue():void
		{
			Assets.getSound("Click").play();
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
		}
		
		public function onExit():void
		{
			Assets.getSound("Click").play();
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			displayTeams.disposeTemporarily();
			logo.disposeTemporarily();
		}
		
	}
}