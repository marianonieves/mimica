package ui
{
	import starling.display.Sprite;

	public class DisplayTeams extends Sprite implements IUIElement 
	{
		public function DisplayTeams()
		{
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}			
	}
}