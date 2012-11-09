package data
{
	public class MatchData
	{
		
		public static var currentTeam:TeamData;
		public static var team1:TeamData;
		public static var team2:TeamData;
		
		// Singleton instance.
		protected static var instance:MatchData;
		public function MatchData(enforcer:AccessRestriction)
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
		}
		
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():MatchData
		{
			if( instance == null )
			{
				instance = new  MatchData(new AccessRestriction());
			}
			
			return instance;
		}
		
		public static function initialize():void
		{
			team1 = new TeamData();
			team1.deserialize({
				teamId:1,
				color:"0xdf0101",
				name:"RED",
				score:0
			});
			
			team2 = new TeamData();
			team2.deserialize({
				teamId:2,
				color:"0x58ACFA",
				name:"BLUE",
				score:0
			});
			currentTeam = team1;
		}
		
		public static function updateScore(score:int):void
		{
			currentTeam.score = score;
			
			if( currentTeam.name == team1.name )
			{
				currentTeam = team2;
			} else {
				currentTeam = team1;
			}
			
		}
		
	}
}
class AccessRestriction {}