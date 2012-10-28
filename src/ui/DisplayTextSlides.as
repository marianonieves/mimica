package ui
{
	import embeds.LocalizatedTexts;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class DisplayTextSlides extends Sprite implements IUIElement 
	{
		private var textBackground:Image;
		private var textField:TextField;
		
		public function DisplayTextSlides()
		{
			textBackground = new Image(Assets.getAtlasTexture("backgroundbutton"));
			textBackground.width = 320;
			textBackground.height = 250;
			addChild(textBackground);
						
			// add textField
			textField = new TextField(300,240,"...","Verdana",16);
			textField.x = 10;
			textField.y = 10;
			addChild(textField);			
		}
		
		public function set text(s:String):void
		{
			textField.text = s;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}				
	}
}