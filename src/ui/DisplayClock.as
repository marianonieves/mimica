package ui
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class DisplayClock extends Sprite implements IUIElement 
	{
		private var t:int;
		private var clicks:int=0;
		private var lastClick:int=0;
		private var time:Date;

		private var timeTF:TextField;
		private var background:Image;
		private var callbackAlarm:Function = new Function();

		public var MAX_CLICKS:int = 300;
		
		public function DisplayClock(callback:Function=null)
		{
			callbackAlarm = callback;
			
			timeTF = new TextField(320,80,"......","Verdana",60,0x00ff00,true);
			addChild(timeTF);
			
			reset();
		}
		
		private function tic():void
		{
			clicks--;
			timeTF.text = formatTime(clicks);
			
			if(clicks<MAX_CLICKS/3)
			{	
				timeTF.color = 0xff0000;
				
			} else if(clicks<MAX_CLICKS*2/3) {
				
				timeTF.color = 0xffff00;
				
			} else {
				timeTF.color = 0x00ff00;
			}
			
			if(clicks==0) alarm();
		}
		
		public function alarm():void
		{
			pause();
			Assets.getSound("Alarm").play();
		}
		
		private function formatTime(c:int):String
		{
			var s:int = c%60;
			var m:int = (c-s)/60;
			return m+":"+s;
		}
		
		public function restart():void
		{
			reset();
			start();
		}
		
		public function start():void 
		{
			t = setInterval(tic,1000);
		}

		public function pause():void
		{
			clearInterval(t);
		}
		
		public function reset():void
		{
			clearInterval(t);
			lastClick=clicks;
			clicks=MAX_CLICKS+1;
			tic();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}		
	}
}