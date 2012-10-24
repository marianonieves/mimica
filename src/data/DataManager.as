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
		// FILE db/mimica.s3db
		
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
		
		
		private var sqlConnection:SQLConnection;
		private var initComplete:Boolean = false;
		private var sqlStat:SQLStatement;
		
		private var folderName:String = "db";
		private var fileName:String = "mimica.s3db";

		public function openDatabaseConnection():void{
			
			
			try
			{
				var sessionDBConn:SQLConnection;
				var sessionDBFile:File;
				var selectStmt:SQLStatement;
				
				sessionDBConn = new SQLConnection();        
				var embededSessionDB:File = File.applicationDirectory.resolvePath("db/mimica.s3db");
				
				if (!embededSessionDB.exists)
				{    
					trace("DB Not Found");
				}
				
				var writeSessionDB:File = File.applicationStorageDirectory.resolvePath("db/mimica.s3db");
				
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
			catch(error:Error)
			{
				trace(error);
			}			
			
			// create new sqlConnection
			sqlConnection = new SQLConnection();
			sqlConnection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);
						
			// open database,If the file doesn't exist yet, it will be created
			sqlConnection.openAsync(writeSessionDB);
			
			
/*
			// create new sqlConnection
			sqlConnection = new SQLConnection();
			sqlConnection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			
			if (!File.applicationStorageDirectory.resolvePath(folderName + fileName).exists)	
			{
				// copyFile(fileName);
				
				var buildPath:String = File.applicationDirectory.nativePath;

				var dbFile:File = File.applicationDirectory.resolvePath(folderName + fileName);
				//var dbFile:File = File.applicationStorageDirectory.resolvePath("db/mimica.s3db");
				
				// open database,If the file doesn't exist yet, it will be created
				sqlConnection.openAsync(dbFile);
				
			} else {
				trace("DATABASE NOT FOUND");
			}*/
		}
		
		// connect and init database/table
		private function onDatabaseOpen(event:SQLEvent):void
		{
			// init sqlStatement object
			sqlStat = new SQLStatement();
			sqlStat.sqlConnection = sqlConnection;
			var sql:String = "SELECT * FROM movies";
			sqlStat.text = sql;
			sqlStat.addEventListener(SQLEvent.RESULT, statResult);
			sqlStat.addEventListener(SQLErrorEvent.ERROR, createError);
			sqlStat.execute();
		}
		private function statResult(event:SQLEvent):void
		{
			// refresh data
			var sqlresult:SQLResult = sqlStat.getResult();
			if(sqlresult.data == null){
				getResult();
				return;
			}
			trace( sqlresult.data );
		}
		
		// get data
		private function getResult(tableName:String="movies"):void{
			var sqlquery:String = "SELECT * FROM " + tableName;
			excuseUpdate(sqlquery);
		}
		
		private function createError(event:SQLErrorEvent):void
		{
			trace("Error code:", event.error.detailID);
			trace("Details:", event.error.details);
		}
		private function errorHandler(event:SQLErrorEvent):void
		{
			trace("Error code:", event.error.detailID);
			trace("Details:", event.error.details);
		}
		
		// UPDATE
		private function excuseUpdate(sql:String):void{
			sqlStat.text = sql;
			sqlStat.execute();
		}
		
		// DELETE
		private function deleteById(tableName:String,id:int):void{
			var sqldelete:String = "delete from "+tableName+" where id='" +
				id +
				"'";
			excuseUpdate(sqldelete);
			trace( sqldelete );
		}
		
		
		// INSERT
/*		private function insertemp():void{
			var sqlupdate:String = "Insert into "+tableName+"(id,name,password) values('" +
				name.text +
				"','" +
				password.text  +
				"')";
			trace( sqlupdate );
			excuseUpdate(sqlupdate)
		}
*/		


	}
	
}

class AccessRestriction {}
