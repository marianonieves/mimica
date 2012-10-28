package screens
{	
	import embeds.LocalizatedTexts;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.Background;
	import ui.Logo;
	

	public class GesturesScreen extends Sprite implements IScreen
	{
		private var background:Background;
		private var logo:Logo;
		
		public function GesturesScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("GameCanvas screen onAddedToStage");
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function initialize(params:Object=null):void
		{
			// add Background
			background = new Background();
			addChild(background);
			
			// add Logo
			logo = new Logo();
			addChild(logo);			
			
			/*
			var textArea:TextArea = new TextArea();
			textArea.width = 300;
			textArea.height = 300;
			textArea.text = LocalizatedTexts.getLocalizatedTextByKey("textGesture");
			addChild( textArea. );
			*/
		}
		

/*
		Gestures
		
		To act out a phrase, one usually starts by indicating what category the phrase is in, and how many words are in the phrase. From then on, the usual procedure is to act out the words one at a time (although not necessarily in the order that they appear in the phrase). In some cases, however, it may make more sense to try to act out the "entire concept" of the phrase at once.
		
		To Indicate Categories:
		
		Book title: Unfold your hands as if they were a book.
		Movie title: Pretend to crank an old-fashioned movie camera.
		Play title: Pretend to pull the rope that opens a theater curtain.
		Song title: Pretend to sing.
		TV show: Draw a rectangle to outline the TV screen.
		Quote or Phrase: Make quotation marks in the air with your fingers.
		To Indicate Other Things:
		
		Number of words in the title: Hold up the number of fingers.
		Which word you're working on: Hold up the number of fingers again.
		Number of syllables in the word: Lay the number of fingers on your arm.
		Which syllable you're working on: Lay the number of fingers on your arm again.
		Length of word: Make a "little" or "big" sign as if you were measuring a fish.
		"The entire concept:" sweep your arms through the air.
		"On the nose" (i.e., someone has made a correct guess): point at your nose with one hand, while pointing at the person with your other hand.
		"Sounds like": Cup one hand behind an ear.
		"Longer version of :" Pretend to stretch a piece of elastic.
		"Shorter version of:" Do a "karate chop" with your hand
		"Plural": link your little fingers.
		"Past tense": wave your hand over your shoulder toward your back.
		A letter of the alphabet: move your hand in a chopping motion toward your arm (near the top of your forearm if the letter is near the beginning of the alphabet, and near the bottom of your arm if the letter is near the end of the alphabet).		
*/
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
				
		
	}
}