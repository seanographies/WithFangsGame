package chars 
{
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
	public class FattleSnake extends Entity 
	{
		public var speed:Number;
		public var horizontalFactor:Number;
		public var horizontalFactor2:Number;
		public var verticalFactor:Number;
		public var verticalFactor2:Number;
		public var activateH:Boolean;
		public var activateV:Boolean;
		protected var holdFruit:Boolean;
		protected var health:int = 6;
		
		protected var snakeSpritemap:Spritemap = new Spritemap(GA.ENEMYSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		protected var curAnimation:String = "FullHealth";
		private var gList:Graphiclist = new Graphiclist();
		private var fruits:Image;
		
		protected var sfxHurt:Sfx = new Sfx(GA.FS_HURT);
		protected var sfxDeath:Sfx = new Sfx(GA.CR_DEATH);
		protected var sfxMove:Sfx = new Sfx(GA.FS_MOVE);
		
		/**
		 * @param	horizontal		activate horizontal movement
		 * @param	vertical	activate vertical movement
		 * @param	hfact	limit for the horizontal point of movement(Moves from X to hfact)
		 * @param	vfact	limit for the vertical point of movement(Moves from Y to vfact)
		 * @param	Speed	speed of the entity
		 */
		public function FattleSnake(_x:Number = 0, _y:Number = 0, horizontal:Boolean = false, vertical:Boolean = false, hfact:Number = 100, vfact:Number = 100, Speed:Number = 200, holdFruits:Boolean = false)
		{
			this.x = _x;
			this.y = _y;
			speed = Speed;
			activateH = horizontal;
			activateV = vertical;
			horizontalFactor =hfact + x;
			horizontalFactor2 =_x;
			verticalFactor = vfact;
			verticalFactor2 = y;
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
			handleMovement();
			updateDeath();
			stopSfx();
		}
		
		protected function stopSfx():void {
			if (GV.cavernLevel == true || GV.cSFX == false) {
				sfxMove.stop();
			}
		}
		
		//attaches sprites
		protected function attachSprites():void {
			snakeSpritemap.add("FullHealth", [16, 17, 18, 19, 20], 8, true);
			snakeSpritemap.add("HalfHealth", [21, 22, 23, 24, 25], 12, true);
			snakeSpritemap.centerOO();
			snakeSpritemap.scale = 2;
			snakeSpritemap.play(curAnimation);
			gList.add(snakeSpritemap);
		}
		
		//handles movement of snake
		protected function handleMovement():void {
			if (activateH == true) {
				horizontalMovement();
			}
			
			if (activateV == true) {
				verticalMovement();
			}
			snakeSpritemap.play(curAnimation);
		}
		
		protected function horizontalMovement():void {
			moveRight();
			if ( x > horizontalFactor && speed > 1) {
				speed *= -1;
			}
			if ( x < horizontalFactor2 && speed < 1) {
				speed *= -1;
			}
		}
		
		protected function verticalMovement():void {
			moveUp();
			if ( y < verticalFactor && speed > 1) {
				speed *= -1;
			}
			if ( y > verticalFactor2 && speed < 1) {
				speed *= -1;
			}
		}
		
		protected function moveLeft():void {
			x -= speed * FP.elapsed;
		}protected function moveRight():void {
			x += speed * FP.elapsed;
		}protected function moveUp():void {
			y -= speed * FP.elapsed;
		}protected function moveDown():void {
			y += speed * FP.elapsed;
		}
		
		//updates death of the entity and creates fruit on dead body
		protected function updateDeath():void {
			if (collide("bloodhose", x, y)) {	
				health--;
				speed = 50;
				sfxHurt.play(0.2);
				curAnimation = "HalfHealth";
			}
			
			if (health < 1) {
				if (holdFruit == true) {
					FP.world.add(new Fruits(this.x, this.y));
				}
				sfxMove.stop();
				sfxDeath.play(0.2);
				FP.world.remove(this);
			}
			snakeSpritemap.play(curAnimation);
		}
		
		//attaches image of fruit to the entity
		protected function attachFruits():void {
			fruits = new Image(GA.FRUIT);
			fruits.centerOrigin();
			fruits.x = 2;
			fruits.y = -40;
			gList.add(fruits);
		}	
		
	}

}