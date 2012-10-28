package ui
{
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DisplayGameMenu extends Sprite implements IUIElement 
	{
		
		private var randomButton:Button;
		public var onAction:Function;
		
		public const ACTION_GET_RANDOM_MOVIE:String="ACTION_GET_RANDOM_MOVIE";
		
		public function DisplayGameMenu()
		{
			
			randomButton = new Button(Assets.getAtlasTexture("backgroundbutton"),"OTRA");
			randomButton.y = 0;
			randomButton.addEventListener(Event.TRIGGERED, randomButton_onClick);			
			addChild(randomButton);
		}
		
		public function randomButton_onClick(event:Event):void
		{
			onAction(ACTION_GET_RANDOM_MOVIE);
		}
		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
	}
}