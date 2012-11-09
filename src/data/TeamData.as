package data
{
	public class TeamData
	{
		
		public var teamId:int=0;
		public var color:String="";
		public var name:String="";
		public var score:int=0;
		
		public function TeamData()
		{
			
		}
		
		public function serialize():String
		{
			return name;
		}
		
		public function deserialize(record:*):void
		{
			teamId = (record.teamId)? record.teamId:0;
			color = (record.color)? record.color:"";
			name = (record.name)? record.name:"";
			score = (record.score)? record.score:0;
		}
		
		
	}
}