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
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class PireB extends Entity 
	{
		protected var pireaSpritemap:Spritemap = new Spritemap(GA.BATSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		protected var curAnimation:String = "hover3";
		
		private var _image:Image;
		protected var gList:Graphiclist = new Graphiclist;
		
		private var fruitsFed:int;
		private var gv:GV = new GV;
		
		protected var fruitBar:Image;
		protected var fbx:int = -11;
		protected var fby:int = -37;
		
		//speechbubble
		protected var lineText:Text;
		protected var _speechbubble:Image = new Image(GA.SPEECH_BUBBLE);
		
		protected var sfxFed:Sfx = new Sfx(GA.PIRE_FED)
		
		public function PireB(x:Number=0, y:Number=0) 
		{
			removeFruitsUI();
			
			this.x = x;
			this.y = y;
			
			setHitbox(32, 32, 16, 16);
			layer = 1;
			type = "pireb";
			
			trace("INITIAL Pire B hunger is " + GV.pireBHunger);
			trace("INITIAL Pire B health is " + GV.pireBHealth);
			
			attachSprites();
			addLines();
			handlePlayer();
			handleCavern();
			attachFruitsUI();
			
			graphic = gList;
		}
		
		override public function update():void {
			super.update();
			updateFruitCollision();
			playLine();
			updateSick();
		}
		
		//attaches Sprites
		protected function attachSprites():void {
			pireaSpritemap.add("hover3", [50, 51, 52, 53, 54], GV.FRAMERATE, true);
			pireaSpritemap.add("hover2", [55, 56, 57, 58, 59], 15, true);
			pireaSpritemap.add("hover1", [60, 61, 62, 63, 64], 10, true);
			pireaSpritemap.add("hover0", [65, 66, 67, 68, 69], 5, true);
			pireaSpritemap.centerOO();
			pireaSpritemap.scale = 1.5;
			pireaSpritemap.play(curAnimation);
			gList.add(pireaSpritemap);
		}
		
		protected function attachFruitsUI():void {
			if (GV.pireBHunger == 1) {
				fruitBar = new Image(GA.PFRUITS1);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireBHunger == 2) {
				fruitBar = new Image(GA.PFRUITS2);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireBHunger == 3) {
				fruitBar = new Image(GA.PFRUITS3);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireBHunger == 4) {
				fruitBar = new Image(GA.PFRUITS4);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireBHunger == 5) {
				fruitBar = new Image(GA.PFRUITS5);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireBHunger >= 6) {
				fruitBar = new Image(GA.PFRUITS6);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}
		}
		
		//removes fruits from UI
		protected function removeFruitsUI():void {
			gList.remove(fruitBar);
			fruitBar = null;
		}
		
		//changes fruit UI when feeding in cavern
		protected function updateFruitsUI():void {
			var fed:int = GV.pireBHunger - GV.pireBFruitsFed;
			if (fed <= 0) {
				//no fruits fed
				gList.remove(fruitBar);
			}			if (fed == 1) {
				fruitBar = new Image(GA.PFRUITS1);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (fed == 2) {
				fruitBar = new Image(GA.PFRUITS2);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (fed == 3) {
				fruitBar = new Image(GA.PFRUITS3);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (fed == 4) {
				fruitBar = new Image(GA.PFRUITS4);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (fed == 5) {
				fruitBar = new Image(GA.PFRUITS5);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (fed >= 6) {
				fruitBar = new Image(GA.PFRUITS6);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}
		}
		
		//handles the health and hunger of the Pire
		protected function updateFeeding():void {
			if (GV.pireBFruitsFed >= GV.pireBHunger&& GV.pireBHunger >=2) {
				GV.pireBHealth++;
				GV.pireBHunger-=2;
			}
			if (GV.pireBFruitsFed >= GV.pireBHunger && GV.pireBHunger ==1) {
				GV.pireBHealth++;
				GV.pireBHunger--;
			}
			if (GV.pireBFruitsFed < GV.pireBHunger && GV.pireBFruitsFed > 0 && GV.pireBHealth>=1) {
				GV.pireBHunger--;
			}
			if (GV.pireBFruitsFed == 0&& GV.pireBHunger >0) {
				GV.pireBHunger++;
				GV.pireBHealth--;
			}
			if (GV.pireBFruitsFed == 0 && GV.pireBHunger <= 0) {
				GV.pireBHunger +=2;
			}
			trace("FED Pire B hunger is " + GV.pireBHunger);
			trace("FED Pire B health is " + GV.pireBHealth);
		}
		
		//changes state of Pire when it loses health and affects players traits
		protected function updateSick():void {
			if (GV.pireBHealth > 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireBHealth == 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireBHealth == 2) {
				curAnimation = "hover2";
			}			
			if (GV.pireBHealth == 1) {
				curAnimation = "hover1";
			}			
			if (GV.pireBHealth < 1) {
				curAnimation = "hover0";
			}
			
			pireaSpritemap.play(curAnimation);
		}
		
		//bat collision with fruit increases the fruit fed
		protected function updateFruitCollision():void {
			if (collide("cfruit", x, y)) {
				removeFruitsUI();
				updateFruitsUI();
				sfxFed.play();
			}
		}
		
		//changes bats settings for cavern
		protected function handleCavern():void {
			if (GV.cavernLevel == true) {
				pireaSpritemap.scale = 2;
			}
		}
		
		//updates feeding when player collides into an object
		protected function handlePlayer():void {
			if (GV.exitCavern == true&& GV.playerDeath == false) {
				updateFeeding();
			}
		}
		
		//creates speechBubble
		protected function speechBubble(_ticket:int, _text:String, _line:int):void {
			if (GameManager.LEVEL_TICKET == _ticket) {
				if (GV.LINE_NUMBER == _line) {
					gList.remove(lineText);
					_speechbubble.x = 4;
					_speechbubble.y = -64;
					gList.add(_speechbubble);
					lineText = new Text(_text);
					lineText.size = 12;
					lineText.x = 9;
					lineText.y = 12;
					lineText.color = 0x000000;
					gList.add(lineText);
				}
			}
		}
		
		//add the lines for the speechbublle & displays them depending on level and line no.
		protected function addLines():void {	
			//A1L1
				speechBubble(2, "Someone help! we are lost.", 1);
				speechBubble(2, "He is dead…", 4);
				speechBubble(2, "We need to get back to the tribe,\n our younger sister was left there without\n food. Could you please help us?", 6);
				speechBubble(2, "Let’s move out, it is almost the time of\n the blood moon.", 18);
			//A1L2	
				speechBubble(4, "You won’t need to scavenge.\n The blood moon has started.", 4);
				speechBubble(4, "But be cautious friend… Don’t take your time\n out there. The blood moon only shows\n during a short period before the eclipse.", 7);
			//A1L3
				speechBubble(6, "When a creature has lost their soul and\n their body is still alive, they get shot \ninto a trance where everything they do has\n no meaning or purpose, just a mundane cycle\n of events.", 5);
				speechBubble(6, " Then when they lose all hope, they\nstart to become vicious and their spirit volatile.", 6);
				speechBubble(6, "No, never. Once the soul has departed from\n the body, they can never be the same\n again. Don’t pity these creatures, they\n deserve it.", 8);
			//A1L4
				speechBubble(7, "It is the blood moon, the monsters\n are hopeless, just meandering around the land,\n no purpose, no sensibilities.", 3);
			//A1L5
				speechBubble(9, "It was too frightened to go up the\n mountain and face the dangers that lay\n in its path to retrieve the most\n valuable piece of its life that it\n ran away to the forest.", 4);
			//A2L1
				speechBubble(10, "Are you sure we are supposed to be heading\n East?", 2);
				speechBubble(10, "Why didn’t you do it?", 10);
				speechBubble(10, "Sorry, but I’m just curious, after your\n failed suicide, did you feel something change\n inside you?", 18);
			//A2L2
				speechBubble(11, "Eventually the creature concluded that this\n was because it’s heart was too warm to\n see the cold truth... ", 3);
				speechBubble(11, "So it cut out a hole through its hand to let\n spirits and the souls of others be absorbed \n and the creature could empathize and\n understand others with the utmost truth. ", 4);
				speechBubble(11, "So to free itself of the burden it had created,\n the creature removed its hand and left it here.", 7);
				speechBubble(11, "Don’t do that, you should not return\n to that attitude, you will only eat\n away at your soul and spirit\n and never truly belong.", 13);
			//A3L1
				speechBubble(12, "Thank you very much friend.", 5);
			//A3L2
				speechBubble(13, "She is extremely unfortunate. She was a \n contrarian from the beginning that always\n wanted somewhere to belong.\n Her plan failed...", 5);
				speechBubble(13, " so not only lost her sense of place but\n also who she was. But still, I’m sure you\n could still live without the being,\n the more important is the soul.", 6);
			//A3L3
				speechBubble(15, "It ran away to be isolated,\n cold and sad.", 5);
			//A4
				speechBubble(16, "We are in debt to you.", 1);
				speechBubble(16, "So a new life is created and another\n is lost to compensate for the balance\n of the parallel universes.", 6);
		}
		
		//checks if line number is equal to GV equivalent
		protected function checkLine():void {
			gList.remove(lineText);
			gList.remove(_speechbubble);
		}
		
		//key input function for showing lines
		protected function playLine(): void {
			var pauseWorld:Boolean = true;
			if (Input.pressed(Key.E)) { checkLine(); addLines(); }
			
		}
		
	}
}