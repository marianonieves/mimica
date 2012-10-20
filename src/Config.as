package
{
    import starling.errors.AbstractClassError;

    public class Config
    {
        public function Config() { throw new AbstractClassError(); }
        
        public static var STAGE_WIDTH:int  = 320;
        public static var STAGE_HEIGHT:int = 480;
        public static var ASPECT_RATIO:Number = Config.STAGE_HEIGHT / Config.STAGE_WIDTH;
    }
}