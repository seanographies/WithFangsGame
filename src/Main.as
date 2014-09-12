package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600, 60,false);
		}
		
		override public function init():void {
			super.init();
			FP.world = new GameWorld(GA.TITLE_SCREEN);
			FP.screen.color = 0xFFFFFF;
			//FP.console.enable();
		}
		
		
	}
	
}