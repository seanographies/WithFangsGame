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
	public class ArenaExit extends Entity 
	{
		protected var gm:GameManager = new GameManager();
		protected var _image:Image = new Image(GA.CEXITG);
		
		public function ArenaExit(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			_image.centerOO();
			graphic = _image;
			setHitbox(16, 16, 8, 8);
			type = "aexit";
			layer = GC.LAYER_OBJS;
		}
		
		override public function update():void {
			super.update();
			updateCollision();
		}
		
		protected function updateCollision():void {
			if (collide("player", x, y)) {
				GV.cSFX = true;
				GV.cavernLevel = true;
				GV.exitCavern = false;
				GV.bmEclipse = true;
				GV.pireAFruitsFed = 0;
				GV.pireBFruitsFed = 0;
				GV.pireABFruitsFed = 0;
				FP.world = new GameWorld(GA.CAVERN);
			}
		}
		
	}

}