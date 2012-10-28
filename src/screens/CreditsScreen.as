package screens
{
	import embeds.LocalizatedTexts;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.DisplayTextSlides;
	import ui.Logo;

	public class CreditsScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		private var displayTextArea:DisplayTextSlides;
		
		public function CreditsScreen()
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
			
			setText();
			
			this.visible = true;			
		}
		private function setText():void
		{
			displayTextArea.text = LocalizatedTexts.getLocalizatedTextByKey("CREDITS_CONTENT1");
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
	}
}