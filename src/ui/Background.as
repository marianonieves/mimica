package ui
{
	import starling.display.Image;
	import starling.display.Sprite;

	public class Background extends Sprite implements IUIElement 
	{
		// TODO: reuse the same Background for all screens to reduce memory
		
		private var background:Image;
		
		public function Background()
		{
			// add content
			background = new Image(Assets.getTexture("Background"));
			addChild(background);
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
				
	}
}