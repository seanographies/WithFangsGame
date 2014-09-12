package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author sean singh
	 */
	public class Psyche extends Entity 
	{
		private var psycheSpritemap:Spritemap = new Spritemap(GA.BOSSSPRITES, GV.SPRITE_WIDTH64, GV.SPRITE_HEIGHT64);
		private var curAnimation:String = "left";
		
		private var speed:Number = 50;
		private var _f:Number = 150;
		private var maxY:Number;
		private var minY:Number;
		private var maxX:Number;
		private var minX:Number;
		
		protected var gList:Graphiclist = new Graphiclist();
		
		public function Psyche(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			minY = y;
			maxY = y + _f;
			maxX = x;
			minX = x - _f;
			
			setHitbox(64, 128, 32, 64);
			
			attachSprites();
			graphic = gList;
			type = "creatures";
			layer = GC.LAYER_CR;
		}
		
		override public function update():void {
			super.update();
			updateMovement();
		}
		
		protected function attachSprites():void {
			psycheSpritemap.add("Left", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 14, true);
			psycheSpritemap.add("Right", [10, 11,12, 13, 14,15, 16, 17, 18, 19], 14, true);
			psycheSpritemap.add("UpDown", [20, 21, 22, 23, 24, 25, 26, 27, 28], GV.FRAMERATE, true);
			
			psycheSpritemap.play(curAnimation);
			psycheSpritemap.scale = 2;
			psycheSpritemap.centerOO();
			gList.add(psycheSpritemap);
		}
		
		
		protected function updateMovement():void {
			if (x > minX && y == minY) {
				moveLeft();
				curAnimation = "Left";
			}
			if (x < minX) {
				moveDown();
				curAnimation = "UpDown";
			}
			if (y > maxY) {
				moveRight();
				curAnimation = "Right";
			}
			if (x > maxX) {
				moveUp();
				curAnimation = "UpDown";
			}
			if ( y < minY) {
				moveLeft();
				curAnimation = "Left";
			}
			
			psycheSpritemap.play(curAnimation);
		}
		
		//Directional movement functions for square  movement
		protected function moveLeft():void {
			x -= speed * FP.elapsed;
		}protected function moveRight():void {
			x += speed * FP.elapsed;
		}protected function moveUp():void {
			y -= speed * FP.elapsed;
		}protected function moveDown():void {
			y += speed * FP.elapsed;
		}
		
	}

}