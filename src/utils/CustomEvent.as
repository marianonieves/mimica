package utils
{
    import flash.events.Event;
   
    public class CustomEvent extends Event
    {
		public static const DEFAULT_NAME:String = "com.reintroducing.events.CustomEvent";
		       
		public var data:Object;
		       
		public function CustomEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
   
		public override function clone():Event
		{
			return new CustomEvent(type, this.data, bubbles, cancelable);
		}
		       
		public override function toString():String
		{
			return formatToString("CustomEvent", "data", "type", "bubbles", "cancelable");
		}
	   
    }
}