package ui
{
	import navigation.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class CustomButton extends Sprite implements IUIElement 
	{

		private var btnArea:Button;		
		public var onClick:Function;
		private var label:TextField;
		private var background:Image;
		
		public function CustomButton(labelText:String)
		{
			background = new Image(Assets.getAtlasTexture("backgroundbutton"));
			background.height = 50;
			background.width = 300;
			addChild(background);
			
			label = new TextField(300,50,labelText,"Verdana",20,0x0,true);
			addChild(label);
			
			btnArea = new Button(Assets.getAtlasTexture("hitarea"));
			btnArea.name = "area"
			btnArea.height = 50; 
			btnArea.width = 300;
			btnArea.x = 0;
			btnArea.y = 0;
			btnArea.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnArea);
		}
		
		public function onButtonTriggered(event:Event):void
		{
			Assets.getSound("Click").play();
			if(onClick!=null) onClick();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (btnArea.hasEventListener(Event.TRIGGERED)) btnArea.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
				
	}
}