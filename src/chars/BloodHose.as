package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class BloodHose extends Entity 
	{
		[Embed(source = "../../assets/blood.png")] private static const BLOODHOSE:Class;
		protected var _image:Image;
		public var counter:int = 0;
		public var angles:Number;
		public var timeLimit:int = 4;
		protected var counterTimer:Boolean = true;
		
		public function BloodHose(angle:Number = 0)
		{
			angles = angle;
			_image = new Image(BLOODHOSE);
			_image.centerOO();
			_image.scale = 1.5;
			_image.angle = angle;
			graphic = _image;
			
			setHitbox(32, 32, 16, 16);
			type = "bloodhose";
			layer = GC.LAYER_BLOODHOSE;
		}
		
		override public function update():void {
			super.update();
			updateHitbox();
			//timer
			if (counterTimer = true) {
				counter++;
				if (counter == timeLimit) {
					FP.world.recycle(this);
					counter = 0;
				}
			}
		}
		
		public function updateHitbox():void {
			if (angles == 90) {
				setHitbox(28, 70, 16, 30);
			}
			if (angles == 270) {
				setHitbox(28, 100, 14,50);
			}
			if (angles == 180) {
				setHitbox(100, 28, 50,14);
			}
			if (angles == 0) {
				setHitbox(100, 28, 50,16);
			}
			
		}
		
	}

}