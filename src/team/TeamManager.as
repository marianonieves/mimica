package team
{
	import data.TeamData;
	
	import flash.utils.Dictionary;

	public class TeamManager
	{
		public var teams:Vector.<TeamData> = new Vector.<TeamData>;
		
		public function TeamManager()
		{
			teams.push( new TeamData().deserialize({
				teamId:1,
				color:"0xff0000",
				name:"red",
				score:0
			}) );
			
			teams.push( new TeamData().deserialize({
				teamId:2,
				color:"0x0000ff",
				name:"blue",
				score:0
			}) );
				
		}
		
		public function disposeTemporarily():void
		{
			teams = null;
		}
		
	}
}