package  
{
	/**
	 * ...
	 * @author sean singh
	 */
	public class GV 
	{
		//General
		public static var SPRITE_WIDTH:Number = 32;
		public static var SPRITE_HEIGHT:Number = 32;
		public static var FRAMERATE:Number = 20;
		public static var SPRITE_WIDTH64:Number = 64;
		public static var SPRITE_HEIGHT64:Number = 64;
		public static var LINE_NUMBER:int = 0;
		
		//Player Vars
		public static var fruitsCollected:int;
		public static var bloodCount:int;
		public static var playerHealth:int;
		
		//Controllers
		public static var bmEclipse:Boolean = false;
		public static var bmStart:Boolean = false;
		public static var cavernLevel:Boolean = false;
		public static var draculaLevel:Boolean = false;
		public static var exitCavern:Boolean = false;
		public static var endCredits:Boolean = false;
		public static var titleScreen:Boolean = false;
		public static var playerDeath:Boolean = false;
		public static var cSFX:Boolean = true;
		public static var a1L1:Boolean = false;
		
		//Pire Vars
		public static var pireAHealth:int = 5;
		public static var pireAHunger:int = 1;
		public static var pireAFruitsFed:int = 0;		
		public static var pireBHealth:int = 4;
		public static var pireBHunger:int =2;
		public static var pireBFruitsFed:int = 0;		
		public static var pireABHealth:int = 4;
		public static var pireABHunger:int = 1;
		public static var pireABFruitsFed:int = 0;
		
		//speech bubble
		public static var PLAYER_SB_X:int = 0;
		public static var PLAYER_SB_Y:int = 0;
		
		
		public function GV() {
			//trace("GV Initiated");
		}
		
		// to be called in the cavern
		public function clearFruits():void {
			fruitsCollected = 0;
			trace(fruitsCollected);
		}
		
	}

}