package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * SPEED
	 * ...
	 * @author sean singh
	 */
	
	public class PireA extends Entity 
	{
		protected var pireaSpritemap:Spritemap = new Spritemap(GA.BATSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		protected var curAnimation:String = "hover3";
		protected var gList:Graphiclist = new Graphiclist;
		
		private var fruitsFed:int;
		private var gv:GV = new GV;
		
		protected var fruitBar:Image;
		protected var fbx:int = -11;
		protected var fby:int = -37;
		
		//speechbubble
		protected var lineText:Text;
		protected var _speechbubble:Image = new Image(GA.SPEECH_BUBBLE);
		
		protected var sfxFed:Sfx = new Sfx(GA.PIRE_FED);
		
		public function PireA(x:Number=0, y:Number=0) 
		{
			removeFruitsUI();
			this.x = x;
			this.y = y;
			
			setHitbox(32, 32, 16, 16);
			layer = 1;
			type = "pirea";
			
			
			trace("INITIAL Pire A hunger is " + GV.pireAHunger);
			trace("INITIAL Pire A health is " + GV.pireAHealth);
			
			attachSprites();
			addLines();
			handlePlayer();
			handleCavern();
			attachFruitsUI();
			
			graphic = gList;
		}
		
		override public function update():void {
			super.update();
			playLine();
			updateFruitCollision();
			updateSick();
		}
		
		//attaches Sprites
		protected function attachSprites():void {
			pireaSpritemap.add("hover3", [30, 31, 32, 33, 34], GV.FRAMERATE, true);
			pireaSpritemap.add("hover2", [35, 36, 37, 38, 39], 15, true);
			pireaSpritemap.add("hover1", [40, 41, 42, 43, 44], 10, true);
			pireaSpritemap.add("hover0", [45, 46, 47, 48, 49], 5, true);
			pireaSpritemap.centerOO();
			pireaSpritemap.scale = 1.5;
			pireaSpritemap.play(curAnimation);
			gList.add(pireaSpritemap);
		}
		
		//attachs fruits to UI in cavern and Arena
		protected function attachFruitsUI():void {
			if (GV.pireAHunger == 1) {
				fruitBar = new Image(GA.PFRUITS1);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireAHunger == 2) {
				fruitBar = new Image(GA.PFRUITS2);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireAHunger == 3) {
				fruitBar = new Image(GA.PFRUITS3);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireAHunger == 4) {
				fruitBar = new Image(GA.PFRUITS4);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireAHunger == 5) {
				fruitBar = new Image(GA.PFRUITS5);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireAHunger >= 6) {
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
			var fed:int = GV.pireAHunger - GV.pireAFruitsFed;
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
			if (GV.pireAFruitsFed >= GV.pireAHunger && GV.pireAHunger >=2) {
				GV.pireAHealth++;
				GV.pireAHunger-=2;
			}	
			if (GV.pireAFruitsFed >= GV.pireAHunger && GV.pireAHunger ==1) {
				GV.pireAHealth++;
				GV.pireAHunger--;
			}
			if (GV.pireAFruitsFed < GV.pireAHunger && GV.pireAFruitsFed > 0 && GV.pireAHealth>=1) {
				GV.pireAHunger--;
			}
			if (GV.pireAFruitsFed == 0 && GV.pireAHunger >0) {
				GV.pireAHealth--;
				GV.pireAHunger++;
			}
			if (GV.pireAFruitsFed == 0 && GV.pireAHunger <= 0) {
				GV.pireAHunger +=2;
			}
			trace("FED Pire A hunger is " + GV.pireAHunger);
			trace("FED Pire A health is " + GV.pireAHealth);
		}
		
		//changes state of Pire when it loses health and affects players traits
		protected function updateSick():void {
			if (GV.pireAHealth > 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireAHealth == 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireAHealth == 2) {
				curAnimation = "hover2";
			}			
			if (GV.pireAHealth == 1) {
				curAnimation = "hover1";
			}			
			if (GV.pireAHealth < 1) {
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
			if (GV.cavernLevel) {
				pireaSpritemap.scale = 2;
			}
		}
		
		//updates feeding when player collides into an object
		protected function handlePlayer():void {
			if (GV.exitCavern == true && GV.playerDeath == false) {
				updateFeeding();
			}
		}
		
		//creates speechBubble
		protected function speechBubble(_ticket:int, _text:String, _line:int):void {
			if (GameManager.LEVEL_TICKET == _ticket) {
				if (GV.LINE_NUMBER == _line) {
					gList.remove(lineText);
					_speechbubble.x = 6;
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
				speechBubble(2, "Please wake up...\n No.. no no, we need you.. please...\n we can't do this alone. We need you...", 0);
				speechBubble(2, "Our father he's not breathing...", 3);
				speechBubble(2, "Please help us, we are lost. We came out\n with our father to hunt for food and\n he got attacked. We have been stranded here\n for days.", 5);
				speechBubble(2, "Good-Bye father.", 19);
			//A1L2	
				speechBubble(4, "We are starving, please could you spare us\n some food?", 0);
				speechBubble(4, "Yes, thank you friend.", 2);
			//A1L3	
				speechBubble(6, "Those were the ones that hurt father.", 0);
				speechBubble(6, "Yes, these creatures are awakened by both\n of the realms. They only wander the\n earth during the blood moon season.", 4);
				speechBubble(6, "But I can see that your soul never\b left you,\n It must have saw the potential\n energy you had and stayed to feed of it.", 10);
			//A1L4
				speechBubble(7, "Don’t be afraid!", 2);
			//A1L5	
				speechBubble(9, "Yes creatures have, but Snail was too\n proud for others to help him,\n the only way is for it to save itself. ", 6);
			//A2L1
				speechBubble(10, "There, the cold hand.\n It’s the cold hand.", 0);
				speechBubble(10, "How do you know this place so well?\n Is this where you live?", 4);
				speechBubble(10, "But...Why?", 6);
				speechBubble(10, "That’s… terrible", 9);
				speechBubble(10, "I will help you friend and so will my\n brother and sister.", 14);
			//A2L2
				speechBubble(11, "But why did you hide yourself?", 10);
				speechBubble(11, "You are searching for your being?", 14);
			//A3L1
				speechBubble(12, "But we can go ourselves, we have already\n burdened you with this", 2);
				speechBubble(12, "Thank you friend, we cannot survive\n without your help.", 4);
			//A3L2
				speechBubble(13, "Yes, that’s her.", 1);
				speechBubble(13, "That is correct, this is what you may\n have become if you had not gone\n out in search for tour being.", 10);
			//A3L3
				speechBubble(15, "It sacrificed everything just to live alone\n with its true identity.", 7);
			//A4
				speechBubble(16, "This is our tribe. Friend, thank you\n very much, we could not have done\n this without you.", 0);
		}
		
		//checks if line number is equal to GV equivalent
		protected function checkLine():void {
			gList.remove(lineText);
			gList.remove(_speechbubble);
		}
		
		//key input function for showing lines
		protected function playLine(): void {
			if (Input.pressed(Key.E)) { checkLine(); addLines(); }
		}
		
		}

}