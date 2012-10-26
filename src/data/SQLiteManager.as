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
		
		public const ST_CLOSED:String = "ST_CLOSED";
		public const ST_READY:String = "ST_READY";
		public const ST_WORKING:String = "ST_WORKING";
		
		public var status:String = ST_CLOSED;
		public var onInitialize:Function = new Function;
		public var onResultCallback:Function = new Function;
		
		
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
			
			if (!File.applicationStorageDirectory.resolvePath("mimica.db").exists)	
			{
				var embededSessionDB:File = File.applicationDirectory.resolvePath("db/mimica_original.db");
				
				if (!embededSessionDB.exists)
				{    
					trace("DB Not Found");
				}
				
				var writeSessionDB:File = File.applicationStorageDirectory.resolvePath("mimica.db");
				
				try
				{
					if (!writeSessionDB.exists) {            
						embededSessionDB.copyTo(writeSessionDB);
					}
				}
				catch(err:Error)
				{  
					trace(err);
				}
			}
			
			openDatabaseConnection();
		}
		
		private function openDatabaseConnection():void
		{
			var db:File = File.applicationStorageDirectory.resolvePath("mimica.db");
			sqlConnection.addEventListener(SQLEvent.OPEN, onSQLOpen);
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlConnection.openAsync(db);
		}
		
		private function onSQLOpen(e:SQLEvent):void
		{
			SQLcall.addEventListener(SQLEvent.RESULT, onSQLResult);
			SQLcall.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			SQLcall.sqlConnection = sqlConnection;
			
			status = ST_READY;
			
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