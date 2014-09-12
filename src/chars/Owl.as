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
	import net.flashpunk.tweens.motion.CircularMotion;
	import objs.Fruits;

	/**
	 * ...
	 * @author sean singh
	 */
	public class Owl extends Entity 
	{
		private var Radius:Number;
		private var Speed:Number;
		private var Angle:Number;
		private var owlSpritemap:Spritemap = new Spritemap (GA.ENEMYSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		protected var curAnimation:String = "Turn1";
		private var fruits:Image;
		private var getFruits:Fruits;
		private var gList:Graphiclist = new Graphiclist();
		private var holdFruit:Boolean;
		protected var health:int =6;
		
		private var circularMotion:CircularMotion = new CircularMotion(null, 1);
		
		protected var sfxBg:Sfx = new Sfx(GA.OWL_BG);
		protected var sfxHurt:Sfx = new Sfx(GA.OWL_HURT);
		protected var sfxDeath:Sfx = new Sfx(GA.CR_DEATH);
		
		/**
		 * @param	r		radius of the circle
		 * @param	speed	speed of the entity
		 */
		public function Owl(_x:Number = 0, _y:Number = 0, r:Number = 50, speed:Number = 200, holdFruits:Boolean = false) 
		{
			this.x = _x;
			this.y = _y;
			Radius = r;
			Speed = speed;
			holdFruit = holdFruits;
			
			setHitbox(16, 46, 8, 16);
			type = "enemy";
			layer = GC.LAYER_CR;
			
			updateCircularMotion();
			
			if (holdFruit == true) {
				attachFruits();
			}
			
			attachSprites();
			graphic = gList;
			sfxBg.loop(0.1);
		}
		
		override public function update():void {
			super.update();
			updateDeath();
			stopSfx();
		}
		
		protected function stopSfx():void {
			if (GV.cavernLevel == true|| GV.cSFX == false) {
				sfxBg.stop();
			}
		}
		
		//attaches the sprites
		protected function attachSprites():void {
			owlSpritemap.add("Turn1", [26], 0, false);
			owlSpritemap.centerOO();
			owlSpritemap.scale = 2;
			owlSpritemap.play(curAnimation);
			gList.add(owlSpritemap);
		}
		
		protected function updateCircularMotion():void {
			Angle = 1 + (360 - 0) * Math.random();
			circularMotion.setMotionSpeed(x, y, Radius, Angle, true, Speed);
			circularMotion.object = this;
			addTween(circularMotion, true);
		}
		
		//creates image of fruit and adds it to gList
		protected function attachFruits():void {
			fruits = new Image(GA.FRUIT);
			fruits.centerOrigin();
			fruits.x = -1;
			fruits.y = -40;
			gList.add(fruits);
		}
		
		//updates the death and creates a fruit if holdFruit is true
		protected function updateDeath():void {
			
			if (collide("bloodhose", x, y)) {
				health --;
				sfxHurt.play(0.2);
			}
			
			
			if (health == 0) {
				if (holdFruit == true) {
					FP.world.add(new Fruits(this.x,this.y));
				}
				sfxDeath.play(0.2);
				sfxBg.stop()
				FP.world.remove(this);
			}
		}
		
		
	}

}