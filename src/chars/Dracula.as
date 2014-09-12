package chars 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
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
	public class Dracula extends Entity 
	{
		protected var _image:Image = new Image(GA.DRACULA);
		protected var gList:Graphiclist = new Graphiclist;
		
		//speechbubble
		protected var lineText:Text;
		protected var _speechbubble:Image = new Image(GA.DSPEECH_BUBBLE);
		
		protected var d1:Sfx = new Sfx(GA.D1_MUSIC);
		protected var d2:Sfx = new Sfx(GA.D2_MUSIC);
		protected var d3:Sfx = new Sfx(GA.D3_MUSIC);
		protected var d4:Sfx = new Sfx(GA.D4_MUSIC);
		protected var d5:Sfx = new Sfx(GA.D5_MUSIC);
		
		public function Dracula(_x:Number=0, _y:Number=0) 
		{
			this.x = _x;
			this.y = _y;
			
			_image.centerOO();
			gList.add(_image);
			
			addLines();
			
			layer = GC.LAYER_PLAYER;
			graphic = gList;
			playMusic();
			stopMusic();
		}
		
		override public function update():void {
			super.update();
			playLine();
			stopMusic();
		}
		
		//plays music for D levels
		protected function playMusic():void {
			if (GameManager.LEVEL_TICKET == 1) {
				d1.loop(0.5);
			}			if (GameManager.LEVEL_TICKET == 3) {
				d1.loop(0.5);
			}			if (GameManager.LEVEL_TICKET == 5) {
				d1.loop(0.5);
			}			if (GameManager.LEVEL_TICKET == 8) {
				d1.loop(0.5);
			}			if (GameManager.LEVEL_TICKET == 14) {
				d1.loop(0.5);
			}
		}
		
		protected function stopMusic():void {
			if (GV.draculaLevel == false) {
				d1.stop();
				d2.stop();
				d3.stop();
				d4.stop();
				d5.stop();
			}
		}
		
		//creates speechBubble
		protected function speechBubble(_ticket:int, _text:String, _line:int):void {
			if (GameManager.LEVEL_TICKET == _ticket) {
				if (GV.LINE_NUMBER == _line) {
					gList.remove(lineText);
					_speechbubble.x = 10;
					_speechbubble.y = -190;
					gList.add(_speechbubble);
					lineText = new Text(_text);
					lineText.size = 12;
					lineText.x = 16;
					lineText.y = -98;
					lineText.color = 0x000000;
					gList.add(lineText);
				}
			}
		}
		
		//add the lines for the speechbublle & displays them depending on level and line no.
		protected function addLines():void {			
			//D1	
				speechBubble(1, "Can I speak now?", 2);
				speechBubble(1, "I see that your shadow is lighter than others.\nThat's because the mask you wear has ridden\n and alienated your being and it has fled.", 4);
				speechBubble(1, "So why return to your true self if you wanted\n to abandon it so desperately?", 7);
				speechBubble(1, "It will not return to you, It is afraid of what\n you have done to it.\nYour only choice is to seek it by removing\n this facade that you wear. ", 11);
				speechBubble(1, "Then show that you are your master no longer\n hiding yourself. ", 13);
				speechBubble(1, "You must force it out of you,do not think\n and act with your mask. Do everything\n to expel it. ", 14);
				speechBubble(1, "Prove to yourself that you want to be found. ", 15);
				speechBubble(1, "Try to recall memories of who you\n once were and let the one thing that\n I sensed you still have not lost guide you. ", 17);
				speechBubble(1, "Your Spirit. That which fosters and holds your\n emotion and empathy. But be cautious, your\n spirit will entwine with those around you,\n holding them vulnerable to your actions.", 19);
			//D2	
				speechBubble(3, "Don’t be so dubious, why just reject all strength\n and confidence in yourself and fail?", 1);
				speechBubble(3, "Those children need you, they are even more\nhelpless without you. This is your responsibility\n, dont throw this on anything else.", 3);
				speechBubble(3, "If you behave like this then you will\n always fail. This is why you never were\n yourself. You couldn’t handle the responsibility\n with the odds against you.", 5);
				speechBubble(3, "That it would just be easier trying to be\n someone else and hide your true emotions. You\n must be alert, hear, see and think. Do not\n underestimate your abilities.", 6);
				speechBubble(3, "Yes, you must change or not you will\n continue to be that lie that you were\n living before. Your spirit is the only guide\n to your being now. Your only true friend.", 8);
				speechBubble(3, "It is inevitable, they will confront you.\n But do not let that consume your mind\n now, you must conquer one struggle at a\n time. The children must be hungry.", 10);
			//D3
				speechBubble(5, "You are proving to the children and myself\n that you are brave and doing the best\n you can to provide. I can see that\n you are listening to your spirit.", 1);
				speechBubble(5, "The other creatures will always be able to\n find other food, don’t worry. The children have\n been starving for days, their condition is\n worse than the other creatures.", 3);
				speechBubble(5, "Monsters no matter large or small are not\n to be feared during the blood moon.\n The blood moon is the collision of the\n realm of the spirit and the realm of\n the being.", 6);
				speechBubble(5, " During the collision there is a equilibrium of\n both characteristics of the universes, this is\n so one does not erupt and take over the\n real world, the one we live in.", 7);
				speechBubble(5, "It will remind you of who you are,\n all the pain you have lived with and\n memories will regain their consciousness\n, increasing the attraction of your being. ", 9);
			//D4
				speechBubble(8, "Do not be afraid of yourself.\n We are all monsters, only different in nature.", 1);
				speechBubble(8, "You are erasing your facade, allowing your\n being to come in. Your body and\n your faculties are adjusting to this sudden\n change. Do not be afraid.", 3);
			//D5
				speechBubble(14, "The world is a sad place with terrible\n creatures.", 1);
				speechBubble(14, "Yes, Psyche is a lot like yourself. Except\n she never learned, but most importantly was\n too late to realized what had left and never\n received the support that could have...", 4);
				speechBubble(14, " challenged her to search for her being.\n You are surprised but there are many\n creatures, all looking for something that is\n lost. But, for you, I see that you are brighter.", 5);
				speechBubble(14, " But all is not done yet, you must\n secure your being. It is now starting to\n settle back but still has not convinced\n itself to stay with you...", 9);
				speechBubble(14, " You must continue to stay true to\n yourself and speak and fight for what you\n love and for the justice which you serve.", 10);
			//A4
				speechBubble(16, "Your being has returned to you, as\n you have returned me the cloud of bats.\n You are your true self now. But,\n you must never forget your journey, ", 7);
				speechBubble(16, "the feeling of your being-less self\n must always remain in your mind to\n remind yourself of all the pain you...", 8);
				speechBubble(16, " have gone through so it can never\n happen again. I know now that you\n will forever cherish your being and that\n you will support and... ", 9);
				speechBubble(16, " help other creatures find their lost selves\n as well. For now,\n you are reborn as Arrowhead.", 10);
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