package screens
{
	import com.greensock.TweenLite;
	
	import navigation.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.Logo;
	
	import utils.Utils;
	
	public class WelcomeScreen extends Sprite implements IScreen
	{
		private var background:Background;		
		private var logo:Logo;
		
		private var btnGame1:Button;
		private var btnGame2:Button;
		private var btnGame3:Button;
		private var btnGame4:Button;
		
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
	
			
			var menu_offset_y:Number = 100;
			
			btnGame1 = new Button( Assets.getAtlasTexture("backgroundbutton"),"JUGAR");
			btnGame1.name = "btnGame1";
			btnGame1.x = 0;
			btnGame1.y = menu_offset_y;
			btnGame1.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame1);

			btnGame2 = new Button(Assets.getAtlasTexture("backgroundbutton"),"EQUIPOS");
			btnGame2.name = "btnGame2";
			btnGame2.x = 0;
			btnGame2.y = btnGame1.y + btnGame1.height;
			btnGame2.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame2);
			
			btnGame3 = new Button(Assets.getAtlasTexture("backgroundbutton"),"GESTOS");
			btnGame3.name = "btnGame3";
			btnGame3.x = 0;
			btnGame3.y = btnGame2.y + btnGame1.height;
			btnGame3.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnGame3);
			
			btnGame4 = new Button(Assets.getAtlasTexture("backgroundbutton"),"REGLAS");
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
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "teams"}, true));
					break;
				case "btnGame3":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "gestures"}, true));
					break;
				case "btnGame4":
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "teams"}, true));
					break;
			}
		}

		public function disposeTemporarily():void
		{
			this.visible = false;

			if (btnGame1.hasEventListener(Event.TRIGGERED)) btnGame1.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame2.hasEventListener(Event.TRIGGERED)) btnGame2.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame3.hasEventListener(Event.TRIGGERED)) btnGame3.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnGame4.hasEventListener(Event.TRIGGERED)) btnGame4.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
	}
}