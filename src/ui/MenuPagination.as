package ui
{
	import embeds.LocalizatedTexts;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	public class MenuPagination extends Sprite implements IUIElement 
	{
		public var onAction:Function;
		
		private var btnNext:Button;
		private var btnPrev:Button;
		
		public const ACTION_NEXT:String="ACTION_NEXT";
		public const ACTION_PREV:String="ACTION_PREV";
		
		public function MenuPagination()
		{
			btnPrev = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_GESTURES_PREV"));
			btnPrev.name = ACTION_PREV;
			btnPrev.x = 0;
			btnPrev.y = 0;
			btnPrev.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnPrev);
			
			btnNext = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_GESTURES_NEXT"));
			btnNext.name = ACTION_NEXT;
			btnNext.x = btnNext.x + btnNext.width + 20;
			btnNext.y = 0;
			btnNext.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnNext);
		}
		
		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			onAction(Button(event.target).name);
		}	
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (btnNext.hasEventListener(Event.TRIGGERED)) btnNext.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnPrev.hasEventListener(Event.TRIGGERED)) btnPrev.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
				
	}
}