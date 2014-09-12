package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class BloodSplotch extends Entity 
	{
		private var _image:Image;
		
		public function BloodSplotch(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			_image = new Image(GA.BSPLOTCH);
			_image.centerOO();
			
			graphic = _image;
			
			setHitbox(32, 32, 16, 16);
			type = "bloodsplotch";
		}
		
		override public function update():void {
			super.update();
			updateMovement();
			updateCollision();
		}
		
		protected function updateMovement():void {
			y += 6;
		}
		
		protected function updateCollision():void {
			var bloodLimit:int = 2;
			
			if (collide("player", x, y)) {
				FP.world.remove(this);
			}
		}
		
	}

}