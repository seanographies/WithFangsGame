package chars 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;	
	import net.flashpunk.Sfx;
	import objs.Fruits;
	/**
	 * ...
	 * @author sean singh
	 */
	public class Snake extends Entity 
	{
		private var snakeSpritemap:Spritemap = new Spritemap(GA.ENEMYSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		private var curAnimation:String = "left";
		public var speed:Number;
		public var maxY:Number;
		public var minY:Number;
		public var maxX:Number;
		public var minX:Number;
		protected var holdFruit:Boolean;
		protected var health:int = 2;
		
		protected var gList:Graphiclist = new Graphiclist();
		private var fruits:Image;
		private var getFruits:Fruits;
		
		protected var sfxDeath:Sfx = new Sfx(GA.CR_DEATH);
		protected var sfxMove:Sfx = new Sfx(GA.S_MOVE);
		
		/**
		 * @param	_f		factor to be add to maxY and subtracted from minX
		 * @param	Speed	speed of the entity
		 */
		public function Snake(_x:Number = 0, _y:Number = 0, _f:Number = 50, Speed:Number = 100, holdFruits:Boolean = false) 
		{
			this.x = _x;
			this.y = _y;
			speed = Speed;
			minY = y;
			maxY = y + _f;
			maxX = x;
			minX = x - _f;
			holdFruit = holdFruits;
			
			setHitbox(32, 32, 16, 16);
			type = "enemy";
			
			if (holdFruit == true) {
				attachFruits();
			}
			
			sfxMove.loop(0.2);
			
			attachSprites();
			graphic = gList;
			layer = GC.LAYER_CR;
		}
		
		override public function update():void {
			super.update();
			updateMovement();
			updateDeath();
			stopSfx();
		}
		
		protected function stopSfx():void {
			if (GV.cavernLevel == true || GV.cSFX == false) {
				sfxMove.stop();
			}
		}
		
		//adds sprites
		protected function attachSprites():void {
			snakeSpritemap.add("Left", [0, 1, 2, 3], GV.FRAMERATE, true);
			snakeSpritemap.add("Right", [4, 5, 6, 7], GV.FRAMERATE, true);
			snakeSpritemap.add("Up", [8, 9, 10, 11], GV.FRAMERATE, true);
			snakeSpritemap.add("Down", [12, 13, 14, 15], GV.FRAMERATE, true);
			snakeSpritemap.centerOO();
			snakeSpritemap.scale = 2;
			snakeSpritemap.play(curAnimation);
			gList.add(snakeSpritemap);
		}
		
		// AI square movement
		protected function updateMovement():void {
			if (x > minX && y == minY) {
				moveLeft();
				curAnimation = "Left";
			}
			if (x < minX) {
				moveDown();
				curAnimation = "Down";
			}
			if (y > maxY) {
				moveRight();
				curAnimation = "Right";
			}
			if (x > maxX) {
				moveUp();
				curAnimation = "Up";
			}
			if ( y < minY) {
				moveLeft();
				curAnimation = "Left";
			}
			
			snakeSpritemap.play(curAnimation);
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
		
		// attaches image of fruit to the entity
		protected function attachFruits():void {
			fruits = new Image(GA.FRUIT);
			fruits.centerOrigin();
			fruits.x = -1;
			fruits.y = -16;
			gList.add(fruits);
		}
		
		//updates death of entity and creates fruit on dead body
		protected function updateDeath():void {
			if (collide("bloodhose", x, y)) {
				health --;
			}
			
			if (health == 0) {
				if (holdFruit == true) {
					FP.world.add(new Fruits(this.x,this.y));
				}
				sfxMove.stop();
				sfxDeath.play(0.2);
				FP.world.remove(this);
			}
		}
	}

}