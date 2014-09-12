package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Fruits extends Entity 
	{
		private var _image:Image;
		protected var sfxFruit:Sfx = new Sfx(GA.PL_FRUITCOLLECT);
		
		public function Fruits(x:Number,y:Number) 
		{
			this.x = x;
			this.y = y;
			_image = new Image(GA.FRUIT);
			_image.centerOO();
			_image.scale = 2;
			graphic = _image;
			
			setHitbox(32, 32, 16, 16);
			type = "fruit";
			layer = GC.LAYER_OBJS;
		}
		
		override public function update():void {
			super.update();
			updateFruit();
		}
		
		protected function updateFruit():void {
			if (collide("player", x, y)) {
				trace("FRUITS COLLECTED" + GV.fruitsCollected);
				sfxFruit.play(0.2);
				FP.world.remove(this);
			}
		}
		
	}

}