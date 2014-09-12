package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.motion.CircularMotion;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Alien extends Entity 
	{
		private var creatureSpritemap:Spritemap = new Spritemap(GA.BOSSSPRITES, GV.SPRITE_WIDTH64, GV.SPRITE_HEIGHT64);
		
		private var speed:Number = 30;
		private var _f:Number = 200;
		private var Radius:Number = 80;
		private var Speed:Number = 100;
		private var Angle:Number;
		
		protected var gList:Graphiclist = new Graphiclist();
		
		private var circularMotion:CircularMotion = new CircularMotion(null, 1);
		
		public function Alien(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			attachSprites();
			updateCircularMotion();
			setHitbox(64, 64, 32, 32);
			type = "creatures";
			super(x, y, gList);
			layer = GC.LAYER_CR;
		}
		
		override public function update():void {
			super.update();
		}
		
		protected function attachSprites():void {
			creatureSpritemap.add("float", [30, 31, 32, 33, 34], 4, true);
			creatureSpritemap.centerOO();
			creatureSpritemap.scale = 2;
			creatureSpritemap.play("float");
			gList.add(creatureSpritemap);
		}
		
		protected function updateCircularMotion():void {
			Angle = 1 + (360 - 0) * Math.random();
			circularMotion.setMotionSpeed(x, y, Radius, Angle, true, Speed);
			circularMotion.object = this;
			addTween(circularMotion, true);
		}
		
	}

}