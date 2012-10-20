package navigation
{
	
	import starling.display.Sprite;
	import screens.GameScreen;
	import screens.WelcomeScreen;

	public class NavigationManager
	{
		
		private var stage:Sprite;
		
		private var screenWelcome:WelcomeScreen;
		private var screenInGame:GameScreen;
		
		
		public function NavigationManager()
		{
		}
		
		public function initialize(baseStage:Sprite):void
		{
			this.stage = baseStage;
			
			
			screenInGame = new GameScreen();
			screenInGame.disposeTemporarily();
			this.stage.addChild(screenInGame);
			
			screenWelcome = new WelcomeScreen();
			this.stage.addChild(screenWelcome);
		}
		
		public function onChangeScreen(event:NavigationEvent):void
		{
			trace("NavigationManager > event.params.id:" + event.params.id)
			switch (event.params.id)
			{
				case "welcome":
					screenWelcome.initialize();
					screenInGame.disposeTemporarily();
					break;
				case "play":
					screenWelcome.disposeTemporarily();
					screenInGame.initialize({game:event.params.game});
					break;
			}
		}
		
		
	}
}