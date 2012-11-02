package data
{
	
	import embeds.LocalizatedTexts;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import utils.Settings;
	
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
		public const Q_GET_SETTINGS:String = "SELECT * FROM settings";
				
		//
		// COMPOSED QUERIES, eg: doSQLcall(Q_GET_ALL_PLAYERS_BY_TEAM_ID,{teamId:1});
		//
		public const Q_GET_ALL_PLAYERS_BY_TEAM_ID:String = "SELECT * FROM players WHERE teamId = <teamId>";
		public const Q_UPDATE_SETTINGS:String = "update settings set lang = '<lang>'";
		
		public var onInitialize:Function;

		// Singleton instance.
		protected static var instance:DataManager;
		public function DataManager(enforcer:AccessRestriction)
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
		public static function getInstance():DataManager
		{
			if( instance == null )
				instance = new  DataManager(new AccessRestriction());
			
			return instance;
		}
				
		public function initialize(callback:Function):void
		{
			onInitialize = callback;
			SQLiteManager.getInstance().initialize(SQLiteManager_onInitialize);
			
		}
		
		public function SQLiteManager_onInitialize():void
		{
			onInitialize();
			
			/*
			trace("nextMovieFromRaw START -----")
			nextMovieFromRaw();
			*/			
		}
		
		public function getRandomMovie(callback:Function):void
		{
			SQLiteManager.getInstance().doSQLcall(Q_GET_RANDOM_MOVIE,null,callback);
		}
		
		public function getSettings(callback:Function):void
		{
			SQLiteManager.getInstance().doSQLcall(Q_GET_SETTINGS,null,callback);
		}
		
		public function updateSettings(callback:Function):void
		{
			SQLiteManager.getInstance().doSQLcall( Q_UPDATE_SETTINGS, {lang:Settings.lang}, callback );
		}
		
		
/*
		*****
		** CODE TO ADD MORE CONTENT
		*****
		
		private var moviesRaw:Array = LocalizatedTexts.moviesRaw;
		private var counterRaw:int=-1;
		private var recordMovie:Object;
		private var record_temp:Array;
		public const Q_ADD_NEW_MOVIE:String = "INSERT INTO Movies (title_es,title_en,genres,year,tagline,code) VALUES ('<title_es>', '<title_en>', '<genres>', '<year>', '<tagline>', '<code>' )";
			
		public function nextMovieFromRaw(o:*=null):void
		{
			counterRaw++;
			trace("nextMovieFromRaw ----- next " + counterRaw);
			
			record_temp = String(moviesRaw[counterRaw]).split(";");
			
			recordMovie = {
				title_es:record_temp[1],
				title_en:record_temp[2],
				genres:record_temp[4],
				year:record_temp[3],
				tagline:record_temp[5],
				code:record_temp[0]
			}
			
			SQLiteManager.getInstance().doSQLcall(Q_ADD_NEW_MOVIE,recordMovie,nextMovieFromRaw);
		}
*/
		
	}
}

class AccessRestriction {}
