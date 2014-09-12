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
	public class CavernExit extends Entity 
	{
		protected var _image:Image;
		protected var gm:GameManager = new GameManager;
		
		public function CavernExit(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			
			setHitbox(32,32,16,16);
			type = "cexit";
			layer = GC.LAYER_OBJS;
		}
		
		override public function update():void {
			super.update();
			changeGraphic();
			updateCollision();
		}
		
		protected function changeGraphic():void {
			if(GameManager.LEVEL_TICKET < 16){
				if (GV.draculaLevel == true) {
					_image = new Image(GA.CEXIT);
					_image.scale = 2;
					_image.centerOO();
				}else {
					_image = new Image(GA.CEXITG);
					_image.scale = 2;
					_image.centerOO();
				}
				graphic = _image;
			}
		}
		
		protected function updateCollision():void {
			if (collide("player", x, y)) {
				GV.cSFX = true;
				GV.exitCavern = true;
				GV.cavernLevel = false;
				GV.bmEclipse = false;
				GV.draculaLevel = false;
				GameManager.LEVEL_TICKET++;
				gm.changeLevel();
			}
		}
	}

}