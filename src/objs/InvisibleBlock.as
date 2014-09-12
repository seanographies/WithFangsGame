package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class InvisibleBlock extends Entity 
	{
		
		public function InvisibleBlock(_x:Number=0, _y:Number=0) 
		{
			super(_x, _y);
			
			setHitbox(32, 32, 16, 16);
			type = "block";
			
		}
		
	}

}