package
{	
	import com.testflightapp.sdk.TestFlight;

	public class Feedback
	{		
		public function Feedback()
		{
		}
		
		public function initialize(TEAM_NAME:String,TEAM_TOKEN:String):void
		{
			
			trace("TestFlight.isSupported: " + TestFlight.isSupported );
			// Only required function, but see below...
			TestFlight.takeOff(TEAM_TOKEN);
			
			// Optional setup
			TestFlight.addCustomEnvironmentInformation("user", TEAM_NAME);
			
			// Optional submission of device identifier
			// Will send UDID if this function is called
			TestFlight.setDeviceIdentifier();
			
			// Lastly, you can tweak TestFlight internal settings
			TestFlight.setOptions({ logToConsole: true });			
		}
		
		
		public function passCheckpoint(checkpoint:String):void
		{
			// You may register checkpoint
			TestFlight.passCheckpoint(checkpoint);
		}
		
		public function submitFeedback(message:String):void
		{
			// Or launch the feedback view
			TestFlight.openFeedbackView();
			// Alternatively, supply your own feedback string
			TestFlight.submitFeedback(message);
		}
		
	}
}