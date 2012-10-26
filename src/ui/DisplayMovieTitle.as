package ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class DisplayMovieTitle extends Sprite implements IUIElement 
	{
		
		private var titleTF:TextField;
		private var background:Image;
		
		public function set text(s:String):void
		{
			titleTF.text = s;
		}
		
		public function DisplayMovieTitle()
		{
			background = new Image(Assets.getAtlasTexture("backgroundbutton"));
			background.height = 140;
			background.width = 320;
			addChild(background);
			
			titleTF = new TextField(320,140,"......","Verdana",15,0xff0000);
			addChild(titleTF);
		}

		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
	}
}