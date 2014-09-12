package chars 
{
	import flash.events.TextEvent;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import objs.CavernExit;
	import objs.CavernFruit;
	import objs.Fruits;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Player extends Entity 
	{
		protected var playerSpritemap:Spritemap = new Spritemap(GA.BATSPRITES, GV.SPRITE_WIDTH, GV.SPRITE_HEIGHT);
		protected var curAnimation:String = "flyRight";
		
		
		protected var _v:Point;
		protected var moveSpeed:Number = 180;
		protected var health:int;
		protected var fruitAry:Array = new Array();
		
		//Sfx
		protected var sfxShoot:Sfx = new Sfx(GA.PL_SHOOT);
		protected var sfxBloodCollect:Sfx = new Sfx(GA.PL_BLOODCOLLECT);
		protected var sfxDeath:Sfx = new Sfx(GA.PL_DEATH);
		protected var sfxHurt:Sfx = new Sfx(GA.PL_HURT);
		
		protected var healthBar:Image;
		protected var fruitBar:Image;
		
		protected var gList:Graphiclist = new Graphiclist();
		protected var s:String;
		protected var t:Text;
		protected var bloodCount:int = GV.bloodCount;
		protected var gm:GameManager = new GameManager;
		
		//speechbubble
		protected var lineText:Text;
		protected var _speechbubble:Image = new Image(GA.SPEECH_BUBBLE);
		protected var hover:Boolean = false;
		[Embed(source = "../../assets/BMgermar.TTF", fontName = "BMgermar", mimeType = "application/x-font-truetype",fontWeight="normal", fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")] private static const FONT:Class;
		
		public function Player(p:Point) 
		{
			health = GV.playerHealth;
			x = p.x;
			y = p.y;
			_v = new Point;
			
			setHitbox(32, 32, 16, 16);
			type = "player";
			layer = GC.LAYER_PLAYER;
			
			attachSprites();
			addLines();
			updateTraits();
			
			graphic = gList;
			Text.font = "BMgermar";
		}
		
		override public function update():void {
			super.update();
			handleBlood();
			handleCavern();
			updateDeath();
			updateBsplotchCollision();
			updateFruitCollision();
			handleDraculaLevel();
			pressEnter();
			endState();
			playLine();
		}
		
		//press enter
		protected function pressEnter():void {
			if (GameManager.LEVEL_TICKET == 0) {
				if (Input.check(Key.ENTER)) { GameManager.LEVEL_TICKET++; gm.changeLevel(); }
			}
		}
		
		//player end/credits state
		protected function endState():void {
			if (GV.endCredits == true) {
				curAnimation = "flyRight";
				playerSpritemap.play(curAnimation);
				y += 3;
			}
		}
		
		//player movement and sprite changes dependent on levels & cheat keys
		protected function updateMovement():void {
			var movement:Point = new Point;
			var verticalMovement:Boolean = true;
			var horizontalMovement:Boolean = true;
			
			var moveUp:String;
			var moveDown:String;
			var moveRight:String;
			var moveLeft:String;
			var still:String;
			
			//sprite controllers
			if (GV.cavernLevel == false) {
				moveUp = "flyRight";
				moveDown = "flyDown";
				moveLeft = "flyLeft";
				moveRight = "flyRight";
				still = "flyDown";
			}else {
				moveUp = "frontUp";
				moveDown = "frontUp";
				moveLeft = "frontLeft";
				moveRight = "frontRight";
				still = "frontStill";
			}
			if(GV.draculaLevel == true){
				moveUp = "backUp";
				moveDown = "frontUp";
				moveLeft = "backLeft";
				moveRight = "backRight";
				still = "backStill";
			}
			
			playerSpritemap.play(curAnimation);
			
			if (Input.check(Key.W)) { movement.y--; curAnimation = moveUp;}
			else if (Input.check(Key.S)) { movement.y++; curAnimation = moveDown; }
			else verticalMovement = false;
				
			if (Input.check(Key.A)) { movement.x--; curAnimation = moveLeft; }
			else if (Input.check(Key.D)) { movement.x++; curAnimation = moveRight; }
			else horizontalMovement = false;
				
			if ((!verticalMovement) && (!horizontalMovement)) {
				curAnimation = still;
			}
			
			_v.x = movement.x * FP.elapsed * moveSpeed;
			_v.y = movement.y * FP.elapsed * moveSpeed;
			x += _v.x;
			y += _v.y;
			
			
			//invisible walls
			if (y < 7) y = 7;
			if (y > FP.height - 7) y = FP.height - 7;
			if (x < 7) x = 7;
			if (x > FP.width - 7) x = FP.width - 7;
			
			//gravity
			if (this.y < FP.height - 7 && verticalMovement == false && GV.cavernLevel == false&&GV.draculaLevel==false) {
				y += 4;
			}
			
			//cheat keys
			//if (Input.pressed(Key.CAPS_LOCK)) { GameManager.LEVEL_TICKET--; gm.changeLevel(); }
			//if (Input.pressed(Key.TAB)) { GameManager.LEVEL_TICKET++; gm.changeLevel(); }
		}
		
		//fire functions
		protected function updateFire():void {
			var shootUp:Boolean = false;
			var shootDown:Boolean = false;
			var shootLeft:Boolean = false;
			var shootRight:Boolean = false;
			
			if (Input.pressed(Key.UP)) { shootUp = true; }
			if (Input.pressed(Key.DOWN)) { shootDown = true; }
			if (Input.pressed(Key.LEFT)) { shootLeft = true; }
			if (Input.pressed(Key.RIGHT)) { shootRight = true; }
			//for each shot triggered, subtracts the blood and updates the blood counter UI
					if (shootUp == true) {
						var newBloodHose:BloodHose = new BloodHose(90);
						newBloodHose.x = x;
						newBloodHose.y = y - 40;
						FP.world.add(newBloodHose);
						bloodCount --;
						removeBlood();
						attachBlood(bloodCount);
						sfxShoot.play(0.2);
					}
					if (shootDown == true) {
						var newBloodHose2:BloodHose = new BloodHose(270);
						newBloodHose2.x = x;
						newBloodHose2.y = y + 40;
						FP.world.add(newBloodHose2);
						bloodCount --;
						removeBlood();
						attachBlood(bloodCount);
						sfxShoot.play(0.2);
					}
					if (shootLeft == true) {
						var newBloodHose3:BloodHose = new BloodHose(180);
						newBloodHose3.x = x - 35;
						newBloodHose3.y = y;
						FP.world.add(newBloodHose3);
						bloodCount --;
						removeBlood();
						attachBlood(bloodCount);
						sfxShoot.play(0.2);
					}
					if (shootRight == true) {
						var newBloodHose4:BloodHose = new BloodHose(0);
						newBloodHose4.x = x + 35;
						newBloodHose4.y = y;
						FP.world.add(newBloodHose4);
						bloodCount --;
						removeBlood();
						attachBlood(bloodCount);
						sfxShoot.play(0.2);
					}
		}
		
		//adds spritemaps
		protected function attachSprites():void {
			playerSpritemap.add("flyRight", [0, 1, 2, 3, 4, 5], GV.FRAMERATE, true);
			playerSpritemap.add("flyLeft", [6, 7, 8, 9, 10, 11], GV.FRAMERATE, true);
			playerSpritemap.add("flyDown", [12, 13, 14], 9, false);
			playerSpritemap.add("frontStill", [15], 0, false);
			playerSpritemap.add("frontUp", [16, 17], GV.FRAMERATE, true);
			playerSpritemap.add("frontRight", [18, 19, 18], GV.FRAMERATE,true);
			playerSpritemap.add("frontLeft", [20, 21, 20], GV.FRAMERATE, true);
			playerSpritemap.add("backStill", [22], 0, false);
			playerSpritemap.add("backUp", [27, 28], GV.FRAMERATE, true);
			playerSpritemap.add("backRight", [23, 24, 23], GV.FRAMERATE, true);
			playerSpritemap.add("backLeft", [25, 26, 25], GV.FRAMERATE, true);
			playerSpritemap.add("death", [29], GV.FRAMERATE, false);
			playerSpritemap.centerOO();
			playerSpritemap.scale = 2;
			playerSpritemap.play(curAnimation);
			gList.add(playerSpritemap);	
		}
		
		//ataches graphics to entity for the UI
		protected function attachUI():void {
			if (GV.cavernLevel == false && GV.draculaLevel == false && GV.endCredits == false && GV.a1L1 == false) {
				// adds the healthbar
				attachHearts();
				//fruits collected
				attachFruits();
			}
		}
		
		//handles the consumption of blood and activation of updatefire()
		protected function handleBlood():void {
			if (bloodCount > 0 && GV.bmEclipse == false && GV.draculaLevel == false&&GV.titleScreen == false&& hover == false) {
				updateFire();
			}
			if (GV.bmEclipse == true || GV.playerHealth < 1 || GV.titleScreen == true||GV.endCredits == true) {
				removeBlood();
			}
		}
		
		//attaches a counter graphic to top left of player and has parameter to import values of blood
		protected function attachBlood(bloodMeasure:int):void {
				var bc:String = new String(bloodMeasure);
				t= new Text(bc);
				t.x = 8;
				t.y = - 27;
				t.color = 0x000000;
				gList.add(t);
		}
		
		//removes the blood counter graphic(for smooth updating of values)
		protected function removeBlood():void {
			gList.remove(t);
		}
		
		//attaches hearts to UI
		protected function attachHearts():void {
				if (health == 1) {
				healthBar = new Image(GA.HEARTS1);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}			if (health == 2) {
				healthBar = new Image(GA.HEARTS2);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}			if (health == 3) {
				healthBar = new Image(GA.HEARTS3);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}			if (health == 4) {
				healthBar = new Image(GA.HEARTS4);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}			if (health == 5) {
				healthBar = new Image(GA.HEARTS5);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}			if (health >= 6) {
				healthBar = new Image(GA.HEARTS6);
				healthBar.x = -32;
				healthBar.y = -200;
				gList.add(healthBar);
			}
		}
		
		//removes hearts from UI
		protected function removeHearts():void {
			gList.remove(healthBar);
		}
		
		//attaches fruits to UI
		protected function attachFruits():void {
			if (GV.fruitsCollected == 0) {
				fruitBar = new Image(GA.FRUITS0);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 1) {
				fruitBar = new Image(GA.FRUITS1);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 2) {
				fruitBar = new Image(GA.FRUITS2);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 3) {
				fruitBar = new Image(GA.FRUITS3);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 4) {
				fruitBar = new Image(GA.FRUITS4);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 5) {
				fruitBar = new Image(GA.FRUITS5);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 6) {
				fruitBar = new Image(GA.FRUITS6);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 7) {
				fruitBar = new Image(GA.FRUITS7);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 8) {
				fruitBar = new Image(GA.FRUITS8);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 9) {
				fruitBar = new Image(GA.FRUITS9);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 10) {
				fruitBar = new Image(GA.FRUITS10);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected == 11) {
				fruitBar = new Image(GA.FRUITS11);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}			if (GV.fruitsCollected >= 12) {
				fruitBar = new Image(GA.FRUITS12);
				fruitBar.x = -20;
				fruitBar.y = +18;
				gList.add(fruitBar);
			}
		}
		
		//removes fruit UI
		protected function removeFruits():void {
			gList.remove(fruitBar);
			fruitBar = null;
		}
		
		//handles fruit collision and attaching/unattaching fruit UI
		protected function updateFruitCollision():void {
			if (collide("fruit", x, y)) {
				GV.fruitsCollected ++;
				removeFruits();
				attachFruits();
			}
		}
		
		// handles death and health functions, damage knockback, movement function
		protected function updateDeath():void {
			if ( health < 1) {
				GV.cSFX = false;
				if (Input.pressed(Key.R)) { GV.playerDeath = true, GV.cSFX = true, FP.world.remove(this), gm.changeLevel() };
				
				sfxDeath.play(0.7);
				curAnimation = "death";
				
				playerSpritemap.play(curAnimation);
				
				removeBlood();
				GV.fruitsCollected = 0;
				GV.playerDeath = false;
				GV.bloodCount = 0;
				bloodCount = 0;
				
				//invisible wall
				if (y < 32) y = 32;
				if (y > FP.height - 32) y = FP.height - 32;
				if (x < 32) x = 32;
				if (x > FP.width - 32) x = FP.width - 32;
			}
			//handles knockback
			if (collide("enemy", x, y) && health >=1) {
				x+= 32;
				y += 32;
				health --;
				removeHearts();
				attachHearts();
				sfxHurt.play(0.2);
			}
			
			//handles movement for death/hovering/end credits
			if (health >= 1 && hover == false &&GV.endCredits == false) {
				updateMovement();
			}
			
			if (collide("creatures", x, y)) {
				x += 32;
				y += 32;
			}
			
		}
		
		//traits affect by health of pires and attaches UI
		protected function updateTraits():void {
			//Health
			if (GV.pireABHealth <= 0) {
				GV.playerHealth = 1;
				health = 1;
				attachUI();
			}			if (GV.pireABHealth == 1) {
				GV.playerHealth = 2;
				health = 2;
				attachUI();
			}			if (GV.pireABHealth == 2) {
				GV.playerHealth = 4;
				health = 4;
				attachUI();
			}			if (GV.pireABHealth == 3) {
				GV.playerHealth = 5;
				health = 5;
				attachUI();
			}			if (GV.pireABHealth >= 4) {
				GV.playerHealth = 6;
				health = 6;
				attachUI();
			}
			//Speed
			if (GV.pireBHealth >= 2) {
				moveSpeed = 180;
			}			if (GV.pireBHealth == 1) {
				moveSpeed = 120;
			}			if (GV.pireBHealth <= 0) {
				moveSpeed = 100;
			}
			//Blood count
			if (GV.pireAHealth >= 5) {
				GV.bloodCount = 5;
				bloodCount = 5;
			}			if (GV.pireAHealth == 4) {
				GV.bloodCount = 4;
				bloodCount = 4;
			}			if (GV.pireAHealth == 3) {
				GV.bloodCount = 3;
				bloodCount = 3;
			}			if (GV.pireAHealth == 2) {
				GV.bloodCount = 2;
				bloodCount = 2;
			}			if (GV.pireAHealth == 1) {
				GV.bloodCount = 1;
				bloodCount = 1;
			}			if (GV.pireAHealth <= 0) {
				GV.bloodCount = 0;
				bloodCount = 0;
			}
			
			if (GV.draculaLevel == false) {
				attachBlood(bloodCount);
			}
			trace("Player Traits lvl ticket: " +GameManager.LEVEL_TICKET +"\n" + "  Health = " + GV.playerHealth + "\n  Speed = " + moveSpeed + "\n  Blood = " + bloodCount + " \n  GV Blood = " + GV.bloodCount);
		}
		
		//bat collision with blood splotch
		protected function updateBsplotchCollision():void {
			//generates random values of blood
			var bloodLimit:int = 0 + (4-0)*Math.random();
			
			if (collide("bloodsplotch", x, y)) {
				removeBlood();
				GV.bloodCount += bloodLimit;
				bloodCount = GV.bloodCount;
				attachBlood(GV.bloodCount);
				sfxBloodCollect.play(0.2);
			}
		}
		
		//In Cavern, increases scale and speed
		protected function handleCavern():void {
			if (GV.cavernLevel) {
				playerSpritemap.scale = 3;
				moveSpeed = 250;
				//TODO: change sprite to: walking animation, no swirl underneath bat
			}
		}
		
		//In dracula level, player has a perimeter
		protected function handleDraculaLevel():void {
			if (GV.draculaLevel == true) {
				//invisible walls
				if (y < 132) y = 132;
				if (y > FP.height - 306) y = FP.height - 306	;
				if (x < 320) x = 320;
				if (x > FP.width - 288) x = FP.width - 288;
			}
		}
		
		//handles collison with invisible block
		protected function updateBlockCollision():void {
			if (collide ("block", x, y)) {
                if (FP.sign(_v.x) > 0){
					_v.x - 0;
					x = Math.floor(x / 40) * 40 + 40 - width;
				}else {
					_v.x - 0;
					x = Math.floor(x / 36) * 36 + 36;
				}
			}
			if (collide ("block", x, y)) {
                if (FP.sign(_v.y) > 0) {
					_v.y - 0;
					y = Math.floor (y / 32) * 32 + 32 - height;
				}else {
					_v.y - 0;
					y = Math.floor (y / 32) * 32+ 32;
				}
			}
		}
		
		//creates speechBubble
		protected function speechBubble(_ticket:int, _text:String, _line:int, _hover:Boolean = true):void {
			if (GameManager.LEVEL_TICKET == _ticket) {
				if (GV.LINE_NUMBER == _line) {
					gList.remove(lineText);
					_speechbubble.x = 8;
					_speechbubble.y = -58;
					gList.add(_speechbubble);
					lineText = new Text(_text);
					lineText.size = 12;
					lineText.x = 9;
					lineText.y = 16;
					lineText.color = 0x000000;
					gList.add(lineText);
					hover = _hover;
					GV.bmStart = false;
				}
			}
		}
		
		//sets hover to free fly and starts blood moon
		protected function freeFly(_ticket:int, _line:int, _hover:Boolean = false, _bmStart:Boolean = true):void {
			removeFruits();
			if (GameManager.LEVEL_TICKET == _ticket) {
				if (GV.LINE_NUMBER == _line) {
					hover = _hover;
					GV.bmStart = _bmStart;
				}
			}
		}
		
		//add the lines for the speechbublle & displays them depending on level and line no.
		protected function addLines():void {
		//D1
				speechBubble(1, "I have dressed myself in a facade for too long.\nThere’s a feeling that I have lost who I truly\n am,an irreplaceable and crucial element of\n my living.", 0);
				speechBubble(1, "My trueself has been swept up onto\n the shore leaving me lost at sea..", 1);
				speechBubble(1, "Yes.", 3);
				speechBubble(1, "Why... But...I never wanted to lose who I truly\n was.I was just afraid that I would be vulnerable\n and isolated if I were myself.", 5);
				speechBubble(1, "So I hid who I really was, never to see\n the light of day.", 6);
				speechBubble(1, "I was naive and blinded by the masses. But\n recently I have seen past the mask and\n I feel extremely lonely.", 8);
				speechBubble(1, "I have realized that all my experiences have\n been a lie, Im living vicariously.", 9);
				speechBubble(1, "I want to live and to feel with my true self,\n to not conform and judge my actions\n based on others approval but for myself.\n I want my being to return to me.", 10);
				speechBubble(1, " I cant! It has shielded me for too long\n that it flows through my veins.", 12);
				speechBubble(1, " How? I don’t see how that will help.\n My mind has been weak ever since\n I felt the loss of my being.", 16);
				speechBubble(1, " What is that?", 18);
				freeFly(1, 20);
		//A1L1
			freeFly(2, 0, true, false);
				speechBubble(2, "What's happened here?", 2);
				speechBubble(2, "Where are you from?", 7);
				speechBubble(2, "I..dont really know where that is.", 9);
				speechBubble(2, "Yes, I am familiar with that region.", 11);
				speechBubble(2, "What about your father?", 13);
				speechBubble(2, "We can’t just leave him here like this.", 15);
				freeFly(2, 20);
		//D2
			speechBubble(3, "Those poor children, they are so helpless.\n I can’t protect them, I need to find someone\n who will and quickly or not they might\n not have a chance.", 0);
			speechBubble(3, "I know I can’t do this. I’m not strong enough.\n I can barely survive on my own. I’m missing\n my being. I’m in no state to do this.", 2);
			speechBubble(3, "I cant deal with this right now, this situation\n is too gigantic for me. I have this innate\n failure I have always lived with, no one\n has ever depended on me, not even myself.", 4);
			speechBubble(3, "I’m sorry...I need to listen to my spirit not my\n mask. I have to fight against the pain,\n agony and tragedy I have lived with\n all my life. I don’t think I could stand to see\nanother creature suffer a similar fate as mine.", 7);
			speechBubble(3, " I have to stand up for myself if\n I’m ever going to be who I truly am.\n I must start now.\nBut even If I take them far, eventually\n we will meet those creatures that lurk.", 9);
			freeFly(3, 11);
		//A1L2
			freeFly(4, 0, true, false);
			speechBubble(4, "I don’t have any food, but there’s some\n fruits over there that I can scavenge for\n you all. Would the fruits be enough?", 1);
			speechBubble(4, "I will return to you when I have collected them.", 3);
			speechBubble(4, "What’s this blood moon?", 5);
			freeFly(4, 8);
		//D3
			speechBubble(5, "I tried to get as much fruits as I could...", 0);
			speechBubble(5, "Yes I am, It’s what I feel is\n right. But there’s a conflict, is what I\n am doing right? I’m stealing all these fruits\n for the children but, what about the other\n creatures?", 2);
			speechBubble(5, "I still fear the monsters though. I’m afraid\n that when we finally come into contact with\n them, I will not be ready and there\n will be nothing I can do to protect\n the children and what I had done previously...", 4);
			speechBubble(5, " for the children would not matter.", 5);
			speechBubble(5, " Does it affect my being? I feel as though\n I’m living in a fantasy world, like I’m\n on the opposite side of reality. It makes\n me feel out of touch with my being.", 8);
			freeFly(5, 10);
		//A1L3
			freeFly(6, 0, true, false);
			speechBubble(6, "They look so insidious.", 1);
			speechBubble(6, "What has made them do such things?\n I have never seen such evil creatures.\n Does the blood moon attract creatures\n of this nature?", 3);
			speechBubble(6, "Can they ever get their souls back?", 7);
			speechBubble(6, "I used to feel like this, that what\n I used to do was just a repetition\n of the same monotonous tasks, I would always\n worry if anything would get better.", 9);
			speechBubble(6, "I guess so, but something else left.", 11);
			freeFly(6, 12);
		//A1L4
			speechBubble(7,"That thing there… Is it …a monster?", 0);
			speechBubble(7, "How did they come to be this way?", 4);
			speechBubble(7, "How could they torture their souls and spirit?\n Why would they do such a thing?", 6);
			freeFly(7, 10);
		//D4
			speechBubble(8, "I was so overwhelmed by fear before\n that when I finally confronted it, my fear\n vanished and all the anger boiled up\n inside me came bursting out and melted the\n monster.It was almost as if I were the monster", 0);
			speechBubble(8, "I exerted all my force without any\n effort. This is all so foreign to me.\n What is happening, I feel so unstable.", 2);
			freeFly(8, 4);
		//A1L5
			speechBubble(9, "Why is that monster crying?", 0);
			speechBubble(9, "Hasn’t anyone helped?\n Surely it can’t just go on living like this?", 5);
			freeFly(9, 7);
		//A2L1
			freeFly(10, 0, true, false);
			speechBubble(10, "We're almost there.", 1);
			speechBubble(10, "Yes I’m sure.", 3);
			speechBubble(10, "No...  This is where I attempted suicide.", 5);
			speechBubble(10, "I was numb everywhere, because\n all I felt was pain, I had reached the moment\n in my life where I had felt and experienced\n everything that i possibly could, I thought \n nothing could get better from here…..", 7);
			speechBubble(10, "that this would have been the happiest I\n could be.", 8);
			speechBubble(10, "Because... I was a failure.\n I’m so hopeless that I can’t even\n take my own life to rid me of my burden.", 11);
			speechBubble(10, "Thank you for your support… I appreciate it.", 17);
			speechBubble(10, "Yes, I lost myself.", 19);
			freeFly(10, 20);
		//A2L2
			speechBubble(11, "What is this cold Hand, I never knew its purpose.", 0);
			speechBubble(11, "But my being lost me, it left me for somewhere\n and something else because I had\n always behaved as who I was not\n and who I was, was thrown into a deep well.", 9);
			speechBubble(11, "I was petrified of being discarded and desolate.\n I wanted to belong, I would do whatever It took\n to be a part of a community. I felt that no one\n was like me, so there was something wrong\n with who I was and...", 11);
			speechBubble(11, " I needed to change that to be\n a part of something, a place to belong.", 12);
			speechBubble(11, " Yes I am. But I’m afraid that\n things have gone too far for too\n long and its beyond my control.\n I’m trying very hard. I’m being alert,\n listening to my spirit.", 15);
			speechBubble(11, " So if my being is so strong,\n why did it leave, couldn’t it have\n overtaken my fantasies and made me believe in\n myself?", 18);
			speechBubble(11, "Yes, but I don’t want to be that thing\n anymore, I want to be myself.\nI want to be able to see things\n with my true thoughts.", 21);
			speechBubble(11, "I need to understand that if i truly\n want to be myself, i must accept myself.", 22);
			freeFly(11, 24);
		//A3L1
			freeFly(12, 0, true, false);
			speechBubble(12, "I can’t leave you guys here all by\n yourselves. I will take you all the way to\n your home and make sure you are all safe.", 1);
			speechBubble(12, "No, you are too young, I will protect\n you all the way back to your home.\n I don’t want anything else to happen to you all.\n Come on we need to get going,\n your sister must be starving and lost.", 3);
			speechBubble(12, "So where do we go from here?", 6);
			freeFly(12, 8);
		//A3L2
			speechBubble(13, "Is that Psyche?", 0);
			speechBubble(13, "She looks extremely lonely, is she looking\n for something?", 2);
			speechBubble(13, "No, the being is the most important,\n it decides your character, your emotions and it\n carves the shape of your virtue. Losing\n it, is the biggest loss any creature can face\n it is the most excruciating torture.", 7);
			speechBubble(13, " Loneliness envelops you and you begin to\n lose your sensibilities, what lies closest to\n your heart, because you have lost purpose.", 8);
			freeFly(13, 11);
		//D5
			speechBubble(14, "All these creatures, they are so lost.\n I never knew that so many creatures were\n troubled by the same problems as me.", 0);
			speechBubble(14, "That girl, Psyche. Her situation is similar to\n mine, she hid herself. But then gave up\n when she realized that her being had\n left and never pursued it. There was\n this dysphoric atmosphere around here... ", 2);
			speechBubble(14, "similar to what I was like when I\n was on the verge of committing suicide.", 3);
			speechBubble(14, "I feel lively as if I have established\n a point in my life whereby I am\n expressing freely my thoughts and emotions,\n and through this discovering who i am,\n I have never felt so fulfilled...", 6);
			speechBubble(14, " Seeing all these creatures who have been\n tormented and rigged of all their being and\n soul and spirit has made me realize that\n I have to keep on fighting and it...", 7);
			speechBubble(14, " has instilled more confidence than I had\n because It has all reminded me of who I was.", 8);
			speechBubble(14, "I know what must be done now, thank you.", 11);
			freeFly(14, 12);
		//A1L3
			speechBubble(15, "I have heard about him, the Alien.\n He is a notorious creature that was the\n first to run away from the grid tribe,\n right?", 0);
			speechBubble(15, "He believed that the tribe was unjust and cruel?", 2);
			speechBubble(15, "I understand, It is just, what the\n creature did. An individual’s identity is the\n most powerful component of a creature, it\n is the mastermind behind what is most\n important, why it lives.", 8);
			speechBubble(15, " Not being with it spends you down\n a spiral of loneliness and misdirection that is\n impossible to climb back up when you\n find yourself at the bottom.", 9);
			freeFly(15, 10);
		//A4
			freeFly(16, 0, true, false);
			speechBubble(16, "Where is your sister?\n Shouldn’t  she be around here?", 2);
			freeFly(16, 11);
		}
		
		//checks if line number is equal to GV equivalent
		protected function checkLine():void {
			gList.remove(lineText);
			gList.remove(_speechbubble);
		}
		
		//key input function for showing lines
		protected function playLine(): void {
			var pauseWorld:Boolean = true;
			if (Input.pressed(Key.E)) { GV.LINE_NUMBER++; checkLine(); addLines();}
			
		}
		
	}

}