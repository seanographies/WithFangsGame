package  
{
	import chars.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import objs.Button;
	import objs.TitleScreen;
	/**
	 * ...
	 * @author sean singh
	 */
	public class GameManager 
	{
		public static var LEVEL_TICKET:int = 0;
		
		//level bg controllers
		public static var BG_A1L1:Boolean = false;
		public static var BG_A1L2:Boolean = false;
		public static var BG_A2:Boolean = false;
		public static var BG_A3:Boolean = false;
		protected var music:Sfx = new Sfx(GA.TITLE_MUSIC);
		public function GameManager() 
		{
			//trace("Gamemanager was called");
		}
		
		//changes levels dependent on LEVEL_TICKET
		public function changeLevel():void {
			//Intro/Dracula Dream I
			if (LEVEL_TICKET == 1) {
				GV.titleScreen = false;
				GV.draculaLevel = true;
				FP.world = new GameWorld(GA.DRACULALVL);
				FP.world.add(new TitleScreen());
				trace("D1");
			}
		//Act I
			//Level I
			if (LEVEL_TICKET == 2) {
				GV.a1L1 = true;
				GV.bmEclipse = true;
				GV.draculaLevel = false;
				resetLevel(true);
				FP.world = new GameWorld(GA.A1L1);
				trace("A1L1");
			}
			//Dracula Dream II
			if (LEVEL_TICKET == 3) {
				GV.a1L1 = false;
				GV.draculaLevel = true;
				resetLevel(false)
				FP.world = new GameWorld(GA.DRACULALVL);
				trace("D2");
			}
			//Level II
			if (LEVEL_TICKET == 4) {
				GV.draculaLevel = false;
				resetLevel(false, true);
				FP.world = new GameWorld(GA.A1L2);
				trace("A1L2");
			}
			//Dracula Dream III
			if (LEVEL_TICKET == 5) {
				GV.draculaLevel = true;
				resetLevel(false, false);
				FP.world = new GameWorld(GA.DRACULALVL);
				trace("D3");
			}
			//Level III
			if (LEVEL_TICKET == 6) {
				GV.draculaLevel = false;
				resetLevel(false, true);
				FP.world = new GameWorld(GA.A1L3);
				trace("A1L3");
			}
			//Level IV
			if (LEVEL_TICKET == 7) {
				resetWorld();
				FP.world = new GameWorld(GA.A1L4);
				trace("A1L4");
			}
			//Dracula Dream IV
			if (LEVEL_TICKET == 8) {
				GV.draculaLevel = true;
				resetLevel();
				FP.world = new GameWorld(GA.DRACULALVL);
				trace("D4");
			}
			//Level V
			if (LEVEL_TICKET == 9) {
				GV.draculaLevel = false;
				resetWorld();
				FP.world = new GameWorld(GA.A1L5);
				trace("A1L5");
			}
		//Act II
			//Level I
			if (LEVEL_TICKET == 10) {
				resetLevel(false, false, true);
				GV.draculaLevel = false;
				FP.world = new GameWorld(GA.A2L1);
				trace("A2L1");
			}
			//Level II
			if (LEVEL_TICKET == 11) {
				resetWorld();
				FP.world = new GameWorld(GA.A2L2);
				trace("A2L2");
			}
		//Act III
			//Level I
			if (LEVEL_TICKET == 12) {
				resetLevel(false, false, false, true);
				FP.world = new GameWorld(GA.A3L1);
				trace("A3L1");
			}
			//Level II
			if (LEVEL_TICKET == 13) {
				resetWorld();
				FP.world = new GameWorld(GA.A3L2);
				trace("A3L2");
			}
			//Dracula Dream V
			if (LEVEL_TICKET == 14) {
				GV.draculaLevel = true;
				resetLevel();
				FP.world = new GameWorld(GA.DRACULALVL);
				trace("D5");
			}
			//Level III
			if (LEVEL_TICKET == 15) {
				GV.draculaLevel = false;
				resetLevel(false, false, false, true);
				FP.world = new GameWorld(GA.A3L3);
				trace("A3L3");
			}
		//Act IV
			//Final Level
			if (LEVEL_TICKET == 16) {
				resetWorld();
				FP.world = new GameWorld(GA.A4);
				trace("A4");
			}
		//End Scene
			//E1
			if (LEVEL_TICKET == 17) {
				GV.endCredits = true;
				FP.world = new GameWorld(GA.ENDING);
				trace("E1");
			}
			//E2
			if (LEVEL_TICKET == 18) {
				FP.world = new GameWorld(GA.ENDING);
				trace("E2");
			}
			//E3
			if (LEVEL_TICKET == 19) {
				FP.world = new GameWorld(GA.ENDING);
				trace("E3");
			}
			//E4
			if (LEVEL_TICKET == 20) {
				FP.world = new GameWorld(GA.ENDING);
				trace("E4");
			}
			//E5
			if (LEVEL_TICKET == 21) {
				FP.world = new GameWorld(GA.ENDING);
				trace("E5");
			}
			//Credits
			if (LEVEL_TICKET == 22) {
				FP.world = new GameWorld(GA.CREDITS);
				trace("Credits");
			}
		}
		
		//resets background level controllers
		public function resetLevel(A1L1:Boolean = false, A1L2:Boolean = false, A2:Boolean = false, A3:Boolean = false):void {
			FP.world.removeAll();
			FP.world.clearTweens();
			BG_A1L1 = A1L1;
			BG_A1L2 = A1L2;
			BG_A2 = A2;
			BG_A3 = A3;
			GV.LINE_NUMBER = 0;
		}
		
		//resets world without specific bg changes
		public function resetWorld():void {
			FP.world.removeAll();
			FP.world.clearTweens();
			GV.LINE_NUMBER = 0;
		}
		
		//Creates Dracula Level background
		public function updateDraculaLevel():void {
			if (GV.draculaLevel == true) {
				var sp:Spritemap = new Spritemap(GA.DRACULASPRITES, 800, 600);
				sp.add("d", [0, 1, 2, 3],4, true);
				sp.play("d");
				sp.alpha = 0.85;
				var e1:Entity = new Entity(0, 0, sp);
				e1.layer = 100;
				FP.world.add(e1);
			}
		}
		
	}

}