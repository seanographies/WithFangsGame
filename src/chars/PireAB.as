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
	public class PireAB extends Entity 
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
		
		protected var sfxFed:Sfx= new Sfx(GA.PIRE_FED);
		
		public function PireAB(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			setHitbox(32, 32, 16, 16);
			layer = GC.LAYER_PIRES;
			type = "pireab";
			
			trace("INITIAL Pire AB hunger is " + GV.pireABHunger);
			trace("INITIAL Pire AB health is " + GV.pireABHealth);
			
			handlePlayer();
			attachSprites();
			addLines();
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
			pireaSpritemap.add("hover3", [70, 71, 72, 73, 74], GV.FRAMERATE, true);
			pireaSpritemap.add("hover2", [75, 76, 77, 78, 79], 15, true);
			pireaSpritemap.add("hover1", [80, 81, 82, 83, 84], 10, true);
			pireaSpritemap.add("hover0", [85, 86, 87, 88, 89], 5, true);
			pireaSpritemap.centerOO();
			pireaSpritemap.scale = 1.5;
			pireaSpritemap.play(curAnimation);
			gList.add(pireaSpritemap);
		}
		
		//creates fruit images and adds them to glist
		protected function attachFruitsUI():void {
			if (GV.pireABHunger == 1) {
				fruitBar = new Image(GA.PFRUITS1);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireABHunger == 2) {
				fruitBar = new Image(GA.PFRUITS2);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireABHunger == 3) {
				fruitBar = new Image(GA.PFRUITS3);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireABHunger == 4) {
				fruitBar = new Image(GA.PFRUITS4);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireABHunger == 5) {
				fruitBar = new Image(GA.PFRUITS5);
				fruitBar.x = fbx;
				fruitBar.y = fby;
				gList.add(fruitBar);
			}			if (GV.pireABHunger >= 6) {
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
			var fed:int = GV.pireABHunger - GV.pireABFruitsFed;
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
			if (GV.pireABFruitsFed >= GV.pireABHunger&& GV.pireABHunger >=2) {
				GV.pireABHealth++;
				GV.pireABHunger-=2;
			}
			if (GV.pireABFruitsFed >= GV.pireABHunger && GV.pireABHunger ==1) {
				GV.pireABHealth++;
				GV.pireABHunger--;
			}
			if (GV.pireABFruitsFed < GV.pireABHunger && GV.pireABFruitsFed > 0&& GV.pireABHealth>=1) {
				GV.pireABHunger--;
			}
			if (GV.pireABFruitsFed == 0&& GV.pireABHunger >0) {
				GV.pireABHealth--;
				GV.pireABHunger++;
			}
			if (GV.pireABFruitsFed == 0 && GV.pireABHunger <= 0) {
				GV.pireABHunger +=2;
			}
			trace("FED Pire AB hunger is " + GV.pireABHunger);
			trace("FED Pire AB health is " + GV.pireABHealth);
		}
		
		//changes state of Pire when it loses health and affects players traits
		protected function updateSick():void {
			if (GV.pireABHealth > 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireABHealth == 3) {
				curAnimation = "hover3";
			}			
			if (GV.pireABHealth == 2) {
				curAnimation = "hover2";
			}			
			if (GV.pireABHealth == 1) {
				curAnimation = "hover1";
			}			
			if (GV.pireABHealth < 1) {
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
				speechBubble(2, "We are children from the birthing tree.", 8);
				speechBubble(2, "Could you take us to the cold hand then?", 10);
				speechBubble(2, "From there we can go ourselves.", 12);
				speechBubble(2, "He is resting, unlike others he is fortunate to\n rest after death.", 14);
				speechBubble(2, "When a creature is killed, it needs to\n be left at its place of death.\n This is for the soul to mourn for its\n long lost partner, the body. From there the\n soul will decide whether to preserve the body...", 16);
				speechBubble(2, "so they can live eternally together or burn it,\n so the soul can be set free", 17);
			//A1L2	
				speechBubble(4, "During the blood moon, those wretched and \nweak creatures that have lived in agony all their\n lives are returned with the blood they have\n shed. They now become the polar opposite of\n the creatures they once were.", 6);
			//A1L3
				speechBubble(6, "They consume the souls of those at peace\n with themselves. It is the easiest prey\n for these creatures.", 2);
			//A1L4
				speechBubble(7, "Yes it is, truly evil beings that only\n lurk during the blood moon.", 1);
				speechBubble(7, "They are creatures who had passed in the\n world and because their souls\n and spirit were tortured by their being,\n this made them monstrous creatures\n in the spirit realm.", 5);
				speechBubble(7, "They consciously chose to be bitter and\n resentful towards others, that their soul and \nspirit disconnected from their being. The mind\n was here but the heart was elsewhere.", 7);
				speechBubble(7, " But to achieve greater execution of their \nintent, they pulled in their lost and desolate\n hearts, forcing the mind and heart to be\n one again. That is torture.", 8);
				speechBubble(7, " During blood moon it is a ritual\n to shed blood of these creatures as offerings,\n this will replenish the blood you have lost.\n Go forth and do not be afraid.", 9);
			//A1L5
				speechBubble(9, "No, it’s not a monster. This is\n a creature called Snail, the legend goes that\n it woke up one day and found that\n it lost its third eye. The one thing that people\n accepted it for and allowed...", 1);
				speechBubble(9, " it to relate to others... Without it, it felt\n completely lost, like life had no purpose\n and that what he was living was a lie. ", 2);
				speechBubble(9, " Later it found out\n that another creature had become envious and\n extracted its third eye and sent it to the top of\n a dangerous mountain. ", 3);
			//A2L1
				speechBubble(10, "But… friend, I can see that you are\n strong now, not a failure, you should\n never feel incompetent or hopeless ever again,\n this is the blood moon, ", 12);
				speechBubble(10, "and you can claim and accept your\n mistakes and losses then heal yourself.", 13);
				speechBubble(10, "I understand the feeling you have gone through…\n I have seen it in some of\n these monsters, they lose themselves and they\n give up when they find themselves at\n the bottom.", 15);
				speechBubble(10, "The only way to beat it is to\n never give in. And that is what\n you are doing.", 16);
			//A2L2
				speechBubble(11, "It symbolizes a creature’s loss of sensibility.\n The monument is from a story of a creature\n that had ventured out into the forest\n to find enlightenment but got lost and...", 1);
				speechBubble(11, "instead started to question its own beliefs and morals.\nIn the end the creature persuaded itself\n that it needed to find truth, that\n the other creatures knew something which it\n didn’t and were all keeping it a secret..", 2);
				speechBubble(11, "It worked as it had been designed,\n but it revealed all the vile secrets\n of other creatures and the hidden identities\n concocted of false and petty things.", 5);
				speechBubble(11, " This was too much for the creature\n to handle, it was immediately frightened.", 6);
				speechBubble(11, " This may explain why you choose this place to\n commit suicide and also why you failed.\n The cold hand must have read your\n being and found it strong and prevented you.", 8);
				speechBubble(11, " No wonder you have such strange powers.\n Your being left your soul with a\n high affinity, this may be why you\n can carry large amounts of blood and...", 16);
				speechBubble(11, " also why myself and my brothers and sisters\n souls are entangled with yours, co-existing\n as one being.", 17);
				speechBubble(11, "No, it couldn’t because your being is\n not in control, you are. You are\n the attraction, it is you who makes\n the changes, your being didn’t leave you,\n you wanted it to leave you to...", 19);
				speechBubble(11, " become something else am I right?", 20);
				speechBubble(11, "You are correct, you must cherish your being.", 23);
			//A3L1
				speechBubble(12, "You have took us far enough friend,\n we are extremely grateful for your efforts.", 0);
				speechBubble(12, "Into the area of Psyche.", 7);
			//A3L2
				speechBubble(13, "She was left behind by her tribe and her\n being. She could never fit in with the\n rest of her tribe. She concluded that\n the problem was with her being...", 3);
				speechBubble(13, " She separated herself from her being in an\n attempt to join her tribe, but was still\n rejected and her being was long gone.\n Now she just waits here, thinking of when\n her being and her tribe will return", 4);
				speechBubble(13, " Her story is very similar to yours,\n except she gave up. She felt that\n things had already taken a turn for the\n worst and that nothing could be salvaged \n and returned.", 9);
			//A3L3
				speechBubble(15, "Yes he is.\n But do you know why he left?", 1);
				speechBubble(15, "Not only that but, he left behind a\n mundane and oppressing life whereby\n creatures could never fully express who\n they were. Their beings were\n locked away underneath...", 3);
				speechBubble(15, " the tribe and no one could ever\n speak to and interact with them. One\n day the alien broke into the chamber of\n beings and stole its being and ran away,\n far away until here.", 4);
				speechBubble(15, "It is not sad, it is only isolated.\n It is a creature now who is at\n peace with itself, because here, far away\n from all the mess it left behind,\n it can truly be free.", 6);
			//A4
				speechBubble(16, "The blood moon sometimes has to make\n sacrifices. This happens when the being of a\n creature has been lost and the owner\n has won it back.", 3);
				speechBubble(16, " It needs energy to be transported back\n into the owner’s body. If the owner\n has lived through its life with agony\n and injustice it consumes a lot of\n energy. So...", 4);
				speechBubble(16, "a sacrifice is chosen to be mended\n together with the being and supplies so\n much power that not only is the\n being returned, but the owner itself is reborn.", 5);
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