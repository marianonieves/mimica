package team
{
	import data.TeamData;
	
	import flash.utils.Dictionary;

	public class TeamManager
	{
		public var teams:Vector.<TeamData> = new Vector.<TeamData>;
		
		public function TeamManager()
		{

		}
		
		public function disposeTemporarily():void
		{
			teams = null;
		}
		
	}
}