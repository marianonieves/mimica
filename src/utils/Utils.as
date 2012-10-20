package utils
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class Utils
	{		
		static public function convertFlashShapeToStaringImage(display:Shape):Image
		{
			var displayBounds:Rectangle = display.getBounds(display)
			var bmd:BitmapData = new BitmapData(displayBounds.width, displayBounds.height, true, 0x000000)
			var matrix:Matrix = new Matrix()
			matrix.tx = -displayBounds.x
				matrix.ty = -displayBounds.y
				bmd.draw(display, matrix)
			var textureReturn:Texture = Texture.fromBitmapData(bmd, false, true)
			var img:Image = new Image(textureReturn);
			bmd.dispose()
			return img;
		}
		
		public static function convertHeightPercentToPixels( percent:int ):int
		{
			var pixel:int = 0;
			pixel = Math.round( Config.STAGE_HEIGHT * percent/100);
			return pixel;
		}
		
		public static function convertWidthPercentToPixels( percent:int ):int
		{
			var pixel:int = 0;
			pixel = Math.round( Config.STAGE_WIDTH * percent/100);
			return pixel;
		}		
		
	}
}