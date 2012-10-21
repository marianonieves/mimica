package ui
{
	import navigation.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Logo extends Sprite
	{
		
		private var logoButton:Button;
		
		public function Logo()
		{
			logoButton = new Button(Assets.getAtlasTexture("logo"));
			logoButton.name = "logo"
			logoButton.height = 65; //mLogo.height * ( mLogo.width*100/Config.STAGE_WIDTH );
			logoButton.width = Config.STAGE_WIDTH;
			logoButton.x = int((Config.STAGE_WIDTH - logoButton.width)  / 2);
			logoButton.y = 10;
			logoButton.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(logoButton);
		}
		
		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (logoButton.hasEventListener(Event.TRIGGERED)) logoButton.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
		
		
	}
}