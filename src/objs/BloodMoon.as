package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;	

	
	/**
	 * ...
	 * @author sean singh
	 */
	public class BloodMoon extends Entity 
	{
		protected var _image:Image;
		private var counter:Number = 0;
		private var timeLimit:int = 2000;
		
		private var gList:Graphiclist = new Graphiclist();
		private var bloodmoonSpritemap:Spritemap = new Spritemap(GA.BLOODMOONSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		private var curAnimation:String = "normal";
		
		public function BloodMoon(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			attachSprites();
			graphic = gList;
			layer = GC.LAYER_OBJS;
			bloodmoonSpritemap.play(curAnimation);
			GV.bmEclipse = false;
		}
		
		override public function update():void {
			super.update();
			updateTimer();
		}
		
		//start timer
		protected function updateTimer():void {
			if (GV.bmStart == true) {
				curAnimation = "p";
				bloodmoonSpritemap.play(curAnimation);
				counter += FP.elapsed;
				if (counter >= 30) {
					counter -= 30;
					GV.bmEclipse = true;
					GV.bmStart = false;
				}
			}
		}
		
		protected function attachSprites():void {
			bloodmoonSpritemap.add("normal", [0]);
			bloodmoonSpritemap.add("p", [0,1,2,3,4,5,6,7,8,910,11,12,13,14],.45, false);
			bloodmoonSpritemap.scale = 2;
			bloodmoonSpritemap.centerOO();
			bloodmoonSpritemap.play(curAnimation);
			gList.add(bloodmoonSpritemap);
		}
		
	}

}