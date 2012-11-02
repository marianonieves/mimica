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
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class SQLiteManager
	{
		private var sqlConnection:SQLConnection = new SQLConnection();
		private var SQLcall:SQLStatement = new SQLStatement();
		private var updateDataBase:Boolean = false;
		
		public const ST_CLOSED:String = "ST_CLOSED";
		public const ST_READY:String = "ST_READY";
		public const ST_WORKING:String = "ST_WORKING";
		
		public var status:String = ST_CLOSED;
		public var onInitialize:Function = new Function;
		public var onResultCallback:Function = new Function;
		
		private var applicationDB:File;
		private var storageDB:File;
		
		// Singleton instance.
		protected static var instance:SQLiteManager;
		public function SQLiteManager(enforcer:AccessRestriction)
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
		public static function getInstance():SQLiteManager
		{
			if( instance == null )
				instance = new  SQLiteManager(new AccessRestriction());
			
			return instance;
		}
		
		public function initialize(callback:Function):void
		{
			if( status!=ST_CLOSED )
			{
				callback();
				return;
			}
			
			onInitialize = callback;
			
			applicationDB = File.applicationDirectory.resolvePath("db/mimica_original.db");
			storageDB = File.applicationStorageDirectory.resolvePath("mimica.db");
			
			if (!applicationDB.exists)
			{    
				trace("[ERROR] DB Not Found in the applicationDirectory");
				return;
				
			} else if (!storageDB.exists) {
				
				createDatabaseFromApplicationToStorage();
				
			}
			
			openDatabaseConnection();
		}
				
		private function createDatabaseFromApplicationToStorage():void
		{
			try
			{
				if (!storageDB.exists ) {            
					trace("[LOG] the DB was created");
					applicationDB.copyTo(storageDB);
				} else {
					trace("[LOG] writeSessionDB.exists");
				}
			}
			catch(err:Error)
			{  
				trace(err);
			}
		}
		
		private function openDatabaseConnection():void
		{
			sqlConnection.addEventListener(SQLEvent.OPEN, onSQLOpen);
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlConnection.openAsync(storageDB);
		}
		
		private function onSQLOpen(e:SQLEvent):void
		{
			SQLcall.addEventListener(SQLEvent.RESULT, onSQLResult);
			SQLcall.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			SQLcall.sqlConnection = sqlConnection;
			
			status = ST_READY;
			
			updateDataBase = false;
			
			if ( updateDataBase ) {
				
				migrateDatabaseFromApplicationToStorage();
				
			} else {
				onInitialize();
			}
			
		}
		
		public function migrateDatabaseFromApplicationToStorage():void
		{
			migrateDatabaseFromApplicationToStorage_onComplete();
		}
		
		public function migrateDatabaseFromApplicationToStorage_onComplete():void
		{
			onInitialize();
		}
		
		public function doSQLcall(query:String, params:*=null, callback:Function=null):void
		{
			if( status!=ST_READY ) 
			{ 
				callback();
				return;
			}

			if( callback!=null ) onResultCallback = callback;
			if( params!=null ) query = replaceParamsInQuery(query,params);
			
			SQLcall.text = query;
			SQLcall.execute();
		}
		
		private function replaceParamsInQuery(query:String, params:*):String
		{
			var keyPattern:RegExp; 
			for (var key:* in params)
			{
				keyPattern = new RegExp("<"+key+">","gi"); 
				query = query.replace(keyPattern,params[key]);
			}
			return query;
		}		
		
		private function onSQLResult(e:SQLEvent):void
		{
			var result:SQLResult = SQLcall.getResult();
			traceRecords(result);
			onResultCallback(result.data);
		}
		
		private function traceRecords(result:SQLResult):void
		{
			var record:String;
			if (result.data != null){
				var i:int;
				for (i = 0; i < result.data.length; i++){
					record = "";
					for (var key:* in result.data[i])
					{
						record += key +":"+ result.data[i][key] + " | ";
					}
					trace("record "+i+" > ", record );
				}
			}			
			
		}
		
		private function onSQLError(e:SQLErrorEvent):void
		{
			trace(e.toString());
		}
		
		
	}
}

class AccessRestriction {}