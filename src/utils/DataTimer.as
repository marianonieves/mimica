package utils
{        
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DataTimer  extends Timer 
	{
		public var data:Object;
		public var callbackOnTimerComplete:Function;
		public var isRepeatable:Boolean=false;
		
		public function DataTimer(delay:Number, callback:Function ) 
		{
			super(delay, 1);
			data = {};
			callbackOnTimerComplete = callback;
			addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		private function onTimerComplete(e:TimerEvent):void
		{
			callbackOnTimerComplete();
			if( isRepeatable )
				startTimer(isRepeatable);
		}
				
		public function startTimer(repeatable:Boolean=false):void
		{
			isRepeatable = repeatable;
			this.start();
		}
		public function pauseTimer():void
		{
			this.stop();
			isRepeatable = false;
		}
		
	}
}