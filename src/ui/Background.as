package ui
{
	import starling.display.Image;
	import starling.display.Sprite;

	public class Background extends Sprite
	{
		// TODO: reuse the same Background for all screens to reduce memory
		
		private var background:Image;
		
		public function Background()
		{
			// add content
			background = new Image(Assets.getTexture("Background"));
			addChild(background);
		}
	}
}