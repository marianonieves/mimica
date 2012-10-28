package screens
{
	import embeds.LocalizatedTexts;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.DisplayTextSlides;
	import ui.Logo;
	import ui.MenuPagination;

	public class RulesScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		private var displayTextArea:DisplayTextSlides;
		private var menu:MenuPagination;
		
		private var indexSlideContent:int=1;
		private var totalSlideContent:int=8;
		
		public function RulesScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Rules screen onAddedToStage");
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
			
			menu = new MenuPagination();
			menu.onAction = menu_onAction;
			menu.y = 340;
			addChild(menu);
			
			setText();
			
			this.visible = true;
		}
		
		private function setText():void
		{
			displayTextArea.text = LocalizatedTexts.getLocalizatedTextByKey("RULES_CONTENT" + indexSlideContent);
		}
		
		
		public function menu_onAction(action:String=""):void
		{
			trace("RulesScreen.menu_onAction:",action);
			
			
			switch (action)
			{
				case menu.ACTION_NEXT:
					indexSlideContent++;
					if( indexSlideContent > totalSlideContent ) indexSlideContent = 1;
					break;
				case menu.ACTION_PREV:
					indexSlideContent--;
					if( indexSlideContent == 0 ) indexSlideContent = totalSlideContent;
					break;
				default:
				{
					trace("[#ERROR#] menu_onAction, NO ACTION")
					break;
				}
			}
			
			setText();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
				
	}
}