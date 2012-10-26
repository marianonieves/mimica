package ui
{
	import data.DataManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import ui.IUIElement;

	public class MovieCard extends Sprite implements IUIElement
	{
		
		private var title:TextField;
		private var randomButton:CustomButton;
		private var background:Image;
		
		public function MovieCard()
		{
			
			background = new Image(Assets.getAtlasTexture("backgroundbutton"));
			background.height = 50;
			background.width = 300;
			addChild(background);
			
			title = new TextField(300,50,"......","Verdana",16,0xff0000);
			addChild(title);
			
			randomButton = new CustomButton("OTRA");
			randomButton.y = 180;
			randomButton.onClick = onClick;
			addChild(randomButton);
			
		}
		
		public function onClick():void
		{
			DataManager.getInstance().getRandomMovie(dataManager_onGetRandomMovie);
		}
		
		private function dataManager_onGetRandomMovie(movieRecord:*=null):void
		{
			title.text = movieRecord[0].title_es;
		}
		
		public function set movieTitle(value:String):void 
		{
			title.text = value;
		}		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}