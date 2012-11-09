package ui
{
	import data.TeamData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class DisplayCurrentTeam extends Sprite implements IUIElement 
	{
		
		private var teamTF:TextField;
		private var background:Image;

		
		public function set team(t:TeamData):void
		{
			teamTF.color = int(t.color);
			teamTF.text = t.name;
		}
		
		public function DisplayCurrentTeam()
		{
/*			background = new Image(Assets.getAtlasTexture("backgroundbutton"));
			background.height = 140;
			background.width = 320;
			addChild(background);
*/			
			teamTF = new TextField(320,20,"......","Verdana",16,0xff0000);
			teamTF.bold = true;
			teamTF.y = 0;
			addChild(teamTF);

		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
	}
}