package screens
{
	import starling.events.TouchEvent;

	public interface IScreen
	{
		function initialize(params:Object=null):void
		function disposeTemporarily():void		
	}
	
	
}