package screens
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;


	public class TwitterReader
	{
		private var twitterScreenName:String = "meteorosrock";
		private var twitterAmount:int = 3;
		
		public function TwitterReader()
		{
			var twitterURL:String = "http://api.twitter.com/1/statuses/user_timeline.json?screen_name="+twitterScreenName+"&count="+ twitterAmount; 
			var twitterRequest:URLRequest = new URLRequest(twitterURL); 
			var twitterLoader:URLLoader = new URLLoader(twitterRequest); 
			twitterLoader.addEventListener(Event.COMPLETE, twitterLoader_onComplete);
		}
		
		public function twitterLoader_onComplete(e:Event):void
		{
			
			var data:Object = JSON.parse( e.target.data );
			twitterScreenName = "@" + twitterScreenName;
			
			trace(twitterScreenName)
			
			for(var i:int=0; i<twitterAmount; i++ )
			{
				trace( tweetToString(data[i]) );
			}
			trace("ok");
		}
		
		private function tweetToString(t:*):String
		{
			var tLine:String =  "'" + trim(t.text) + "' " + formatDate(t.created_at);
			return tLine;
		}
		
		private function trim( s:String ):String
		{
			return s.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
		}
		
		private function formatDate(d:String):String
		{
			// Tue Oct 13 15:10:41 +0000 2009
			var date:Date = new Date(d);
			var fd:String = getDate(date.date) +"."+ getMonth(date.month) +"."+ date.fullYear
			return fd;
		}
		
		private function getDate(d:int):String
		{
			return (d<10)? "0"+d:d.toString();
		}
		
		private function getMonth(m:int):String
		{
			var months:Array = new Array("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic");
			return months[m];
		}
		
				
	}
}