package screens
{
	import navigation.NavigationEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.Logo;
	
	import utils.Utils;
	
	public class TeamsScreen extends Sprite implements IScreen
	{
		private var background:Background;		
		private var logo:Logo;
		
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
			
			
			this.visible = true;
		}

		public function disposeTemporarily():void
		{
			this.visible = false;
			logo.disposeTemporarily();
		}
		
	}
}