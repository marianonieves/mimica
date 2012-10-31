package data
{
	public class DataMovie
	{
		
		public var movieId:int=0;
		public var title_es:String="";
		public var title_en:String="";
		public var year:String="";
		public var genre:String="";
		public var tagline:String="";
		public var code:String="";
		
		public function DataMovie()
		{
			
		}
				
		public function serialize():String
		{
			return title_es;
		}
		
		public function deserialize(record:*):void
		{
			movieId = (record.movieId)? record.movieId:0;
			title_es = (record.title_es)? record.title_es:"";
			title_en = (record.title_en)? record.title_en:"";
			year = (record.year)? record.year:"";
			genre= (record.genre)? record.genre:"";
			tagline = (record.tagline)? record.tagline:"";
			code = (record.code)? record.code:"";
		}
		
		
	}
}