package ui
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import utils.CustomEvent;

	public class ButtonTwoStates extends Sprite implements IUIElement 
	{
		
		private var btnArea:Button;
		public var onClick:Function;
		private var label:TextField;
		private var background:Image;
		private var _enable:Boolean=true;	
		
		public const STATE1:String="STATE1";
		public const STATE2:String="STATE2";
		
		public function ButtonTwoStates(backgroundAtlasTexture:String="backgroundbutton",labelText:String="ButtonTwoStates")
		{
			background = new Image(Assets.getAtlasTexture(backgroundAtlasTexture));
			background.height = 50;
			background.width = 320;
			addChild(background);
			
			label = new TextField(320,50,labelText,"Verdana",20,0x0,true);
			addChild(label);
			
			btnArea = new Button(Assets.getAtlasTexture("hitarea"));
			btnArea.name = "area"
			btnArea.height = 50; 
			btnArea.width = 320;
			btnArea.x = 0;
			btnArea.y = 0;
			btnArea.addEventListener(Event.TRIGGERED, onButtonTriggered);			
			addChild(btnArea);
		}
		
		public function onButtonTriggered(event:Event):void
		{
			if(!_enable) return;
			Assets.getSound("Click").play();
			if(onClick!=null)
			{
				onClick(new CustomEvent(Event.TRIGGERED,this));
			}
		}
		
		public function enable():void {_enable=true;}
		public function disable():void {_enable=false;}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (btnArea.hasEventListener(Event.TRIGGERED)) btnArea.removeEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
		
	}
}