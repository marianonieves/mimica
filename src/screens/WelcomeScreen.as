package screens
{
	import com.greensock.TweenLite;
	
	import navigation.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.Utils;
	
	public class WelcomeScreen extends Sprite implements IScreen
	{
		private var background:Image;
		
		private var mLogo:Button;
		private var btnGame1:Button;
		private var btnGame2:Button;
		private var btnGame3:Button;
		private var btnGame4:Button;
		private var twitterReader:TwitterReader;
		
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
			// add twitter
			twitterReader = new TwitterReader();
			
			
			// add some content
			background = new Image(Assets.getTexture("Background"));
			addChild(background);
			
			// add buttons
			mLogo = new Button(Assets.getAtlasTexture("logo"));
			mLogo.name = "logo"
			mLogo.height = 65; //mLogo.height * ( mLogo.width*100/Config.STAGE_WIDTH );
			mLogo.width = Config.STAGE_WIDTH;
			mLogo.x = int((Config.STAGE_WIDTH - mLogo.width)  / 2);
			mLogo.y = 10;
			addChild(mLogo);
			
			var menu_offset_y:Number = 100;
			
			btnGame1 = new Button( Assets.getAtlasTexture("button1"));
			btnGame1.name = "btnGame1";
			btnGame1.x = 0;
			btnGame1.y = menu_offset_y;
			btnGame1.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame1);

			btnGame2 = new Button(Assets.getAtlasTexture("button2"));
			btnGame2.name = "btnGame2";
			btnGame2.x = 0;
			btnGame2.y = btnGame1.y + btnGame1.height;
			btnGame2.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame2);
			
			btnGame3 = new Button(Assets.getAtlasTexture("button3"));
			btnGame3.name = "btnGame3";
			btnGame3.x = 0;
			btnGame3.y = btnGame2.y + btnGame1.height;
			btnGame3.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame3);
			
			btnGame4 = new Button(Assets.getAtlasTexture("button4"));
			btnGame4.name = "btnGame4";
			btnGame4.x = 0;
			btnGame4.y = btnGame3.y + btnGame1.height;
			btnGame4.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame4);
			
			this.visible = true;
		}
		
		public function onButtonTriggered(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			Assets.getSound("Click").play();
			switch (buttonClicked.name)
			{
				case "btnGame1":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play",game:"game1"}, true));
					break;
				case "btnGame2":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play",game:"game2"}, true));
					break;
				case "btnGame3":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play",game:"game3"}, true));
					break;
				case "btnGame4":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play",game:"game4"}, true));
					break;
			}
		}

		public function disposeTemporarily():void
		{
			this.visible = false;

			if (mLogo.hasEventListener(Event.TRIGGERED)) mLogo.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame1.hasEventListener(Event.TRIGGERED)) btnGame1.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame2.hasEventListener(Event.TRIGGERED)) btnGame2.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame3.hasEventListener(Event.TRIGGERED)) btnGame3.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame4.hasEventListener(Event.TRIGGERED)) btnGame4.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
	}
}