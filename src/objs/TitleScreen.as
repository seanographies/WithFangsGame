package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class TitleScreen extends Entity 
	{
		protected var _image:Image = new Image(GA.TITLESCREEN);
		protected var music:Sfx = new Sfx(GA.TITLE_MUSIC);
		
		public function TitleScreen() 
		{
			graphic = _image;
			layer = GC.LAYER_TITLESCREEN;
			trace("TITLESCREEN");
			music.loop();
			changeLayer();
		}
		
		override public function update():void {
			super.update();
			changeLayer();
		}
		
		protected function changeLayer():void {
			if (GV.titleScreen == false ) {
				layer = 1000;
				music.stop();
			}
		}
		
	}

}