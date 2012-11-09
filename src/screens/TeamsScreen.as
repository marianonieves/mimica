package screens
{
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
			
			// TODO: add display to choose how many teams are going to play the match.
			// add Teams
			displayTeams = new DisplayTeams();
			displayTeams.y = 80;
			addChild(displayTeams);

			
			this.visible = true;
		}

		public function disposeTemporarily():void
		{
			this.visible = false;
			displayTeams.disposeTemporarily();
			logo.disposeTemporarily();
		}
		
	}
}