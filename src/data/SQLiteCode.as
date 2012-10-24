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
	
	public class SQLiteCode
	{

		// Singleton instance.
		protected static var instance:SQLiteCode;
		public function SQLiteCode(enforcer:AccessRestriction)
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
		public static function getInstance():SQLiteCode
		{
			if( instance == null )
				instance = new  SQLiteCode(new AccessRestriction());
			
			return instance;
		}
			

		private var sqlConnection:SQLConnection = new SQLConnection();
		private var SQLcall:SQLStatement = new SQLStatement();
		
		public function start():void
		{
			// C:\Users\playdom\AppData\Roaming\ar.com.marianonieves.mimica.debug
			
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

			doSQLcall(Q_GET_ALL_MOVIES);
		}
		
		private const Q_GET_ALL_MOVIES:String = "SELECT * FROM movies";
		private const Q_GET_ALL_DIFFERENT_GENRES:String = "SELECT DISTINCT genres FROM movies";

		// function to add item to our database
		private function doSQLcall(query:String):void
		{			
			// in this sql statment we add item at the end of our table with values 
			// first_name.text in column first_name and last_name.text for column last_name
			SQLcall.text = query;
			SQLcall.execute();
			
		}		
		private function onSQLResult(e:SQLEvent):void
		{
			var result:SQLResult = SQLcall.getResult();
			traceRecords(result)
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

		
		// method which gets called when we recive an error  from sql connection 
		// or sql statement and displays the error in the alert
		private function onSQLError(e:SQLErrorEvent):void
		{
			trace(e.toString());
		}
		

		
		
	}
}
	
class AccessRestriction {}