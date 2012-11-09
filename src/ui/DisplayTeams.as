package ui
{
	import data.MatchData;
	
	import embeds.LocalizatedTexts;
	
	import screens.TeamsScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class DisplayTeams extends Sprite implements IUIElement 
	{
		public var onAction:Function;
		
		private var btnContinue:Button;
		private var btnEnd:Button;
		
		private var textBackground:Image;
		private var txtTeam1:TextField;
		private var txtTeam2:TextField;
		
		public function DisplayTeams()
		{
/*			textBackground = new Image(Assets.getAtlasTexture("backgroundbutton"));
			textBackground.y = 0;
			textBackground.width = 320;
			textBackground.height = 250;
			addChild(textBackground);
			*/
			txtTeam1 = new TextField(300,40,"...","Verdana",24);
			txtTeam1.x = 10;
			txtTeam1.y = 60;
			txtTeam1.bold = true;
			addChild(txtTeam1);			
			
			txtTeam2 = new TextField(300,40,"...","Verdana",24);
			txtTeam2.x = 10;
			txtTeam2.y = 120;
			txtTeam2.bold = true;
			addChild(txtTeam2);			
			
			btnEnd = new Button(Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_TEAMS_END"));
			btnEnd.name = TeamsScreen.ACTION_END;
			btnEnd.x = 0;
			btnEnd.y = 240;
			btnEnd.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnEnd);
			
			btnContinue = new Button( Assets.getAtlasTexture("backgroundbutton"),LocalizatedTexts.getLocalizatedTextByKey("MENU_TEAMS_CONTINUE"));
			btnContinue.name = TeamsScreen.ACTION_CONTINUE;
			btnContinue.x = btnEnd.x + btnContinue.width + 20;
			btnContinue.y = 240;
			btnContinue.addEventListener(Event.TRIGGERED, onButtonTriggered);		
			addChild(btnContinue);
			
			updateDisplay();
		}

		private function updateDisplay():void
		{
			txtTeam1.color = int(MatchData.team1.color);
			txtTeam1.text = MatchData.team1.name + ": " + MatchData.team1.score;
			txtTeam2.color = int(MatchData.team2.color);
			txtTeam2.text = MatchData.team2.name + ": " + MatchData.team2.score;
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
			if (btnContinue.hasEventListener(Event.TRIGGERED)) btnContinue.removeEventListener(Event.TRIGGERED, onButtonTriggered);
			if (btnEnd.hasEventListener(Event.TRIGGERED)) btnEnd.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}			
	}
}