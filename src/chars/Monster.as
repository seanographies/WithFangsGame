package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;	
	import net.flashpunk.Sfx;
	import objs.BloodSplotch;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Monster extends Entity 
	{
		private var monsterSpritemap:Spritemap = new Spritemap(GA.BLOODMOONSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		private var curAnimation:String = "Right";
		protected var speed:Number = 100;
		protected var horizontalFactor:Number;
		protected var horizontalFactor2:Number;
		
		protected var health:Number = 14;
		
		private var gList:Graphiclist = new Graphiclist();
		
		protected var sfxHurt:Sfx = new Sfx(GA.MS_HURT);
		protected var sfxDeath:Sfx = new Sfx(GA.MS_DEATH);
		
		public function Monster(_x:Number=0, _y:Number=0) 
		{
			this.x = _x;
			this.y = _y;
			horizontalFactor = 200 + _x;
			horizontalFactor2 = _x;
			
			setHitbox(72, 89, 24, 43);
			type = "enemy";
			
			atttachSprites();
			graphic = gList;
			layer = GC.LAYER_CR;
		}
		
		override public function update():void {
			super.update();
			updateMovement();
			handleBloodSplotch();
		}
		
		protected function atttachSprites():void {
			monsterSpritemap.add("Right", [15, 16, 17, 18], 10, true);
			monsterSpritemap.add("Left", [20, 21, 22, 23], 10, true);
			monsterSpritemap.scale = 3;
			monsterSpritemap.centerOO();
			monsterSpritemap.play(curAnimation);
			gList.add(monsterSpritemap);
		}
		
		//handles movement,animation and hitboxes
		protected function updateMovement():void {
			x += speed * FP.elapsed;
			
			if ( x > horizontalFactor && speed > 1) {
				speed *= -1;
				curAnimation = "Left";
				setHitbox(72, 89, 43, 43);
			}
			
			if ( x < horizontalFactor2 && speed < 1) {
				speed *= -1;
				curAnimation = "Right";
				setHitbox(72, 89, 24, 43);
			}
			monsterSpritemap.play(curAnimation);
			
		}
		
		//handles death and blood splotches
		protected function handleBloodSplotch():void {
			if (collide("bloodhose", x, y)) {
				var _bs:BloodSplotch = FP.world.create(BloodSplotch) as BloodSplotch;
				_bs.x = x;
				_bs.y = y;
				FP.world.add(_bs);
				health -= 1;
				sfxHurt.play(0.2);
			}
			
			if (health <= 0) {
				sfxDeath.play(0.2);
				FP.world.remove(this);
			}
		}
		
	}

}