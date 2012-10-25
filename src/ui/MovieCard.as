package ui
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class MovieCard extends Sprite implements IUIElement
	{
		
		private var txtTitle:TextField;
		
		public function MovieCard()
		{
			
			txtTitle = new TextField(160,200,"texto texto","Verdana",16,0xff0000);
			addChild(txtTitle);
		}
		
		public function set movieTitle(value:String):void {
			txtTitle.text = value;
		}		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}