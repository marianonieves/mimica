package data
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class DataManager
	{
		//
		// SIMPLE QUERIES
		//
		public const Q_GET_ALL_MOVIES:String = "SELECT * FROM movies";
		public const Q_GET_ALL_DIFFERENT_GENRES:String = "SELECT DISTINCT genres FROM movies";
		public const Q_GET_RANDOM_MOVIE:String = "SELECT * FROM movies ORDER BY RANDOM() LIMIT 1";
		public const Q_GET_ALL_TEAMS:String = "SELECT * FROM teams";
		public const Q_GET_ALL_PLAYERS:String = "SELECT * FROM players";
		
		//
		// COMPOSED QUERIES, eg: doSQLcall(Q_GET_ALL_PLAYERS_BY_TEAM_ID,{teamId:1});
		//
		public const Q_GET_ALL_PLAYERS_BY_TEAM_ID:String = "SELECT * FROM players WHERE teamId = <teamId>";
		

		// Constructor
		public function DataManager()
		{
		}
		
		public function initialize(callback:Function):void
		{
			SQLiteManager.getInstance().initialize(callback);
		}
		
		public function getRandomMovie(callback:Function):void
		{
			SQLiteManager.getInstance().doSQLcall(Q_GET_RANDOM_MOVIE,null,callback);
		}


	}
}