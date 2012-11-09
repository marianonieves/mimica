package ui
{
	import embeds.LocalizatedTexts;
	
	import screens.GameScreen;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MenuMovieCard extends Sprite implements IUIElement 
	{
		public var onAction:Function;
		
		private var btnOther:Button;
		private var btnReady:Button;
		private var btnPause:Button;
		private var btnGuessed:Button;
		private var btnResume:Button;
		private var btnPenalty:Button;
		
		private var mode:String = MODE_CHOOSE_MOVIE;
		private var original_y:int=-1;
		
		public static const MODE_CHOOSE_MOVIE:String="MODE_CHOOSE_MOVIE";
		public static const MODE_GUESSING:String = "MODE_GUESSING";
		public static const MODE_PAUSED:String = "MODE_PAUSED";
		
		public function MenuMovieCard()
		{
			btnOther = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_OTHER"));
			btnOther.name = GameScreen.ACTION_OTHER;
			btnOther.x = 0;
			btnOther.y = 0;
			btnOther.addEventListener(Event.TRIGGERED, onButtonTriggered);		
			btnOther.visible = false;
			addChild(btnOther);
			
			btnReady = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_READY"));
			btnReady.name = GameScreen.ACTION_READY;
			btnReady.x = btnOther.x + btnReady.width + 20;
			btnReady.y = 0;
			btnReady.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			btnOther.visible = false;
			addChild(btnReady);
			
			btnPause = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_PAUSE"));
			btnPause.name = GameScreen.ACTION_PAUSE;
			btnPause.x = 0; 
			btnPause.y = 0;
			btnPause.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			btnPause.visible = false;
			addChild(btnPause);
			
			btnGuessed = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_GUESSED"));
			btnGuessed.name = GameScreen.ACTION_GUESSED;
			btnGuessed.x = btnPause.x + btnGuessed.width + 20;
			btnGuessed.y = 0;
			btnGuessed.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			btnGuessed.visible = false;
			addChild(btnGuessed);
			
			btnResume = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_RESUME"));
			btnResume.name = GameScreen.ACTION_RESUME;
			btnResume.x = 0; 
			btnResume.y = 0;
			btnResume.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			btnResume.visible = false;
			addChild(btnResume);
			
			btnPenalty = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_MOVIECARD_PENALTY"));
			btnPenalty.name = GameScreen.ACTION_PENALTY;
			btnPenalty.x = btnResume.x + btnResume.width + 20;
			btnPenalty.y = 0;
			btnPenalty.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			btnPenalty.visible = false;
			addChild(btnPenalty);
			
		}
				
		public function setMode(newMode:String):void
		{
			if(original_y<0)original_y=this.y;
			mode = newMode;
			switch(mode)
			{
				case MODE_CHOOSE_MOVIE:
				{
					this.y = original_y;
					btnOther.visible = true;
					btnReady.visible = true;
					btnPause.visible = false;
					btnGuessed.visible = false;
					btnResume.visible = false;
					btnPenalty.visible = false;
					break;
				}
				case MODE_GUESSING:
				{
					this.y = original_y+5;
					btnOther.visible = false;
					btnReady.visible = false;
					btnPause.visible = true;
					btnGuessed.visible = true;
					btnResume.visible = false;
					btnPenalty.visible = false;
					break;
				}					
				case MODE_PAUSED:
				{
					this.y = original_y+10;
					btnOther.visible = false;
					btnReady.visible = false;
					btnPause.visible = false;
					btnGuessed.visible = false;
					btnResume.visible = true;
					btnPenalty.visible = true;
					break;
				}					
				default:
				{
					trace("[#ERROR#] MenuMovieCard_onAction, NO ACTION")
					break;
				}
			}
			
		}
		
		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			var btnTmp:Button = Button(event.target);
			onAction(btnTmp.name);
		}	
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (btnOther.hasEventListener(Event.TRIGGERED)) btnOther.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnReady.hasEventListener(Event.TRIGGERED)) btnReady.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnPause.hasEventListener(Event.TRIGGERED)) btnPause.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGuessed.hasEventListener(Event.TRIGGERED)) btnGuessed.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			
		}
		
	}
}