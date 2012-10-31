package ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class DisplayMovieTitle extends Sprite implements IUIElement 
	{
		
		private var title_esTF:TextField;
		private var title_enTF:TextField;
		private var yearTF:TextField;
		private var taglineTF:TextField;
		private var background:Image;
		
		public function set title_es(s:String):void
		{
			title_esTF.text = s;
		}
		public function set title_en(s:String):void
		{
			title_enTF.text = s;
		}
		public function set year(s:String):void
		{
			yearTF.text = s;
		}
		public function set tagline(s:String):void
		{
			taglineTF.text = s;
		}
		
		public function DisplayMovieTitle()
		{
			background = new Image(Assets.getAtlasTexture("backgroundbutton"));
			background.height = 140;
			background.width = 320;
			addChild(background);
			
			title_esTF = new TextField(320,40,"......","Verdana",16,0xff0000);
			title_esTF.y = 0;
			addChild(title_esTF);
			
			title_enTF = new TextField(320,40,"......","Verdana",14,0xff0000);
			title_enTF.y = 40;
			addChild(title_enTF);
			
			yearTF = new TextField(320,30,"......","Verdana",14,0x000000);
			yearTF.y = 80;
			addChild(yearTF);
			
			taglineTF = new TextField(320,40,"......","Verdana",10,0x000000);
			taglineTF.y = 100;
			addChild(taglineTF);
		}

		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
	}
}