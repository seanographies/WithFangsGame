package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Snail extends Entity 
	{
		private var creatureSpritemap:Spritemap = new Spritemap(GA.BOSSSPRITES, GV.SPRITE_WIDTH64, GV.SPRITE_HEIGHT64);
		protected var gList:Graphiclist = new Graphiclist();
		protected var crySfx:Sfx = new Sfx(GA.SNAIL_CRY);
		
		public function Snail(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			attachSprites();
			setHitbox(64, 128, 32,64);
			type = "creatures";
			layer = GC.LAYER_CR;
			
			super(x, y, gList);
			crySfx.loop(0.7);
		}
		
		override public function update():void {
			super.update();
			stopSfx();
		}
		
		protected function stopSfx():void {
			if (GV.cavernLevel == true || GV.cSFX == false) {
				crySfx.stop();
			}
		}
		
		protected function attachSprites():void {
			creatureSpritemap.add("cry", [35, 36, 37, 38, 39], 9, true);
			creatureSpritemap.centerOO();
			creatureSpritemap.scale = 2;
			creatureSpritemap.play("cry");
			gList.add(creatureSpritemap);
		}
		
	}

}