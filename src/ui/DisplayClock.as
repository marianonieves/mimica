package ui
{
	import flash.events.TimerEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import utils.DataTimer;
	
	public class DisplayClock extends Sprite implements IUIElement 
	{
		private var dataTimer:DataTimer;
		private var clicks:int=0;
		private var lastClick:int=0;
		private var time:Date;

		private var timeTF:TextField;
		private var background:Image;
		private var callbackAlarm:Function = new Function();

		public var MAX_TICS:int = 10;
		
		public function DisplayClock(callback:Function=null)
		{
			callbackAlarm = callback;
			
			timeTF = new TextField(320,80,"......","Verdana",60,0x00ff00,true);
			addChild(timeTF);
			
			dataTimer = new DataTimer(1000, tic);
			
			reset();
		}
		
		private function tic(event:TimerEvent=null):void
		{
			clicks--;
			timeTF.text = formatTime(clicks);
			
			if(clicks<MAX_TICS/3)
			{	
				timeTF.color = 0xff0000;
				
			} else if(clicks<MAX_TICS*2/3) {
				
				timeTF.color = 0xffff00;
				
			} else {
				timeTF.color = 0x00ff00;
			}
			
			if(clicks==0) 
			{
				alarm();
				pause();
			}
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
		
		public function reset():void
		{
			dataTimer.pauseTimer();
			lastClick=clicks;
			clicks=MAX_TICS+1;
			tic();
		}
		
		public function start():void 
		{
			dataTimer.startTimer(true);
		}

		public function pause():void
		{
			dataTimer.pauseTimer();
		}
				
		public function disposeTemporarily():void
		{
			this.visible = false;
			dataTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, tic);
		}		
	}
}