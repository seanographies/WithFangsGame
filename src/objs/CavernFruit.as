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
	public class CavernFruit extends Entity 
	{
		private var _image:Image;
		
		public function CavernFruit(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			_image = new Image(GA.FRUIT);
			_image.centerOO();
			_image.y = -10;
			_image.scale = 3;
			graphic = _image;
			layer = GC.LAYER_OBJS;
			
			setHitbox(16, 16, 8, 8);
			type = "cfruit";
		}
		
		override public function update():void {
			super.update();
			updateCollision();
			updateCloudCollision();
			updateWall();
		}
		
		//collision between fruit and cloud of bats
		protected function updateCloudCollision():void {
			if (collide ("pirea", x, y)) {
				GV.pireAFruitsFed ++;
				FP.world.remove(this);
			}			if (collide ("pireb", x, y)) {
				GV.pireBFruitsFed ++;
				FP.world.remove(this);
			}			if (collide ("pireab", x, y)) {
				GV.pireABFruitsFed ++;
				FP.world.remove(this);
			}
		}
		
		//player push collision
		protected function updateCollision():void {
			if (collide ("player", this.left, y)) {
				x += 32; 
			}
			
			if (collide ("player", this.right, y)) {
				x -= 32; 
			}
			
			if (collide ("player", x, this.top)) {
				y += 32; 
				x = this.x;
			}
			
			if (collide ("player", x, this.bottom)) {
				y -= 32; 
			}
		}
		
		//invisible wall in cavern level
		protected function updateWall():void {
			if ( y < 32) y = 32
			if ( y > FP.height - 32) y = FP.height - 32;
			if (x < 32) x = 32;
			if (x > FP.width - 32) x = FP.width - 32;
		}
	}
}