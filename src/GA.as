package  
{
	import flash.display.LineScaleMode;
	/**
	 * ...
	 * @author sean singh
	 */
	public class GA 
	{
	//Sprites
		[Embed(source = "../assets/Spritesheet-Bats.png")] public static const BATSPRITES:Class;
		[Embed(source = "../assets/Spritesheet-Enemies.fw.png")] public static const ENEMYSPRITES:Class;
		[Embed(source = "../assets/BossSprites.fw.png")] public static const BOSSSPRITES:Class;
		[Embed(source = "../assets/Bloodmoon Sprites.fw.png")] public static const BLOODMOONSPRITES:Class;
		[Embed(source = "../assets/BGs/Dracula bg.fw.png")] public static const DRACULASPRITES:Class;
	//Char images
		//tiles
		[Embed(source = "../assets/tile16.png")] public static const TILES:Class;
		//fruit
		[Embed(source = "../assets/fruit.png")] public static const FRUIT:Class;
		[Embed(source = "../assets/UI/12fruits.fw.png")]public static const FRUITS12:Class;
		[Embed(source = "../assets/UI/11fruits.fw.png")]public static const FRUITS11:Class;
		[Embed(source = "../assets/UI/10fruits.fw.png")]public static const FRUITS10:Class;
		[Embed(source = "../assets/UI/9fruits.fw.png")]public static const FRUITS9:Class;
		[Embed(source = "../assets/UI/8fruits.fw.png")]public static const FRUITS8:Class;
		[Embed(source = "../assets/UI/7fruits.fw.png")]public static const FRUITS7:Class;
		[Embed(source = "../assets/UI/6fruits.fw.png")]public static const FRUITS6:Class;
		[Embed(source="../assets/UI/5fruits.fw.png")]public static const FRUITS5:Class;
		[Embed(source = "../assets/UI/4fruits.fw.png")] public static const FRUITS4:Class;
		[Embed(source = "../assets/UI/3fruits.fw.png")] public static const FRUITS3:Class;
		[Embed(source = "../assets/UI/2fruits.fw.png")] public static const FRUITS2:Class;
		[Embed(source = "../assets/UI/1fruits.fw.png")] public static const FRUITS1:Class;
		[Embed(source = "../assets/UI/0fruits.fw.png")] public static const FRUITS0:Class;
		//pfruit
		[Embed(source = "../assets/UI/6pfruits.fw.png")] public static const PFRUITS6:Class;
		[Embed(source = "../assets/UI/5pfruits.fw.png")] public static const PFRUITS5:Class;
		[Embed(source = "../assets/UI/4pfruits.fw.png")] public static const PFRUITS4:Class;
		[Embed(source = "../assets/UI/3pfruits.fw.png")] public static const PFRUITS3:Class;
		[Embed(source = "../assets/UI/2pfruits.fw.png")]public static const PFRUITS2:Class;
		[Embed(source = "../assets/UI/1pfruits.fw.png")]public static const PFRUITS1:Class;
		//heart
		[Embed(source = "../assets/heart.png")] public static const HEART:Class;
		[Embed(source = "../assets/6hearts.fw.png")] public static const HEARTS6:Class;
		[Embed(source = "../assets/5hearts.fw.png")] public static const HEARTS5:Class;
		[Embed(source = "../assets/4hearts.fw.png")] public static const HEARTS4:Class;
		[Embed(source = "../assets/3hearts.fw.png")] public static const HEARTS3:Class;
		[Embed(source = "../assets/2hearts.fw.png")] public static const HEARTS2:Class;
		[Embed(source = "../assets/1hearts.fw.png")] public static const HEARTS1:Class;
		[Embed(source = "../assets/0hearts.fw.png")] public static const HEARTS0:Class;
		
		//bloodspotch
		[Embed(source = "../assets/BSplotch.png")] public static const BSPLOTCH:Class;
		//blood drop
		[Embed(source = "../assets/blooddrop.png")] public static const BDROP:Class;
		//Pires
		[Embed(source = "../assets/A.png")] public static const PIREA:Class;
		[Embed(source = "../assets/AB.png")] public static const PIREAB:Class;
		[Embed(source = "../assets/B.png")] public static const PIREB:Class;
		//cavern exits
		[Embed(source = "../assets/cavernExit.png")] public static const CEXIT:Class;
		[Embed(source = "../assets/cavernExitGreen.fw.png")] public static const CEXITG:Class;
		//Circles
		[Embed(source = "../assets/64Circle.png")] public static const CIR64:Class;
		[Embed(source = "../assets/128Circle.png")] public static const CIR128:Class;
		[Embed(source = "../assets/256Circle.png")] public static const CIR256:Class;
		[Embed(source="../assets/Dplatform.fw.png")] public static const DCIRCLE:Class;
		//Coldhand
		[Embed(source = "../assets/ColdHand.fw.png")] public static const COLDHAND:Class;
		//dracula
		[Embed(source = "../assets/Dracula.fw.png")] public static const DRACULA:Class;
		//speech bubble
		[Embed(source = "../assets/speechbubble.fw.png")] public static const SPEECH_BUBBLE:Class;
		//Dracula speech bubble
		[Embed(source = "../assets/dspeechbubble.fw.png")] public static const DSPEECH_BUBBLE:Class;
		//dead father
		[Embed(source = "../assets/deadfather.fw.png")] public static const DEAD_FATHER:Class;
		
		//bg
		[Embed(source = "../assets/BGs/Title screen.fw.png")] public static const TITLESCREEN:Class;
		[Embed(source = "../assets/protobg.fw.png")] public static const BG:Class;
		[Embed(source = "../assets/BGs/A1L1.fw.png")] public static const BGA1L1:Class;
		[Embed(source = "../assets/BGs/A1L2.fw.png")] public static const BGA1L2:Class;
		[Embed(source = "../assets/BGs/A1L3.fw.png")] public static const BGA1L3:Class;
		[Embed(source = "../assets/BGs/A1L4.fw.png")] public static const BGA1L4:Class;
		[Embed(source = "../assets/BGs/A1L5.fw.png")] public static const BGA1L5:Class;
		[Embed(source = "../assets/BGs/A2L1.fw.png")] public static const BGA2L1:Class;
		[Embed(source = "../assets/BGs/A2L2.fw.png")] public static const BGA2L2:Class;
		[Embed(source = "../assets/BGs/A3L1.fw.png")] public static const BGA3L1:Class;
		[Embed(source = "../assets/BGs/A3L2.fw.png")] public static const BGA3L2:Class;
		[Embed(source = "../assets/BGs/A3L3.fw.png")] public static const BGA3L3:Class;
		[Embed(source = "../assets/BGs/A4.fw.png")] public static const BGA4:Class;
		[Embed(source = "../assets/BGs/cavern.fw.png")] public static const BGCAVERN:Class;
		[Embed(source = "../assets/BGs/E1.fw.png")] public static const E1:Class;
		[Embed(source = "../assets/BGs/E2.fw.png")] public static const E2:Class;
		[Embed(source = "../assets/BGs/E3.fw.png")] public static const E3:Class;
		[Embed(source = "../assets/BGs/E4.fw.png")] public static const E4:Class;
		[Embed(source = "../assets/BGs/E5.fw.png")] public static const E5:Class;
		[Embed(source = "../assets/BGs/Credits.fw.png")] public static const BGCREDITS:Class;
		
		
	//Title screen/credits
		[Embed(source = "../levels/TitleScreen.oel", mimeType = "application/octet-stream")] public static const TITLE_SCREEN:Class;
		[Embed(source = "../levels/Ending.oel", mimeType = "application/octet-stream")] public static const ENDING:Class;
		[Embed(source = "../levels/Credits.oel", mimeType = "application/octet-stream")] public static const CREDITS:Class;
	//Levels
		[Embed(source = "../levels/Cavern.oel", mimeType = "application/octet-stream")]	public static const CAVERN:Class;
		[Embed(source = "../levels/Dracula.oel", mimeType = "application/octet-stream")] public static const DRACULALVL:Class;
	//ACT I
		[Embed(source = "../levels/A1L1.oel", mimeType = "application/octet-stream")] public static const A1L1:Class;
		[Embed(source = "../levels/A1L2.oel", mimeType = "application/octet-stream")] public static const A1L2:Class;
		[Embed(source = "../levels/A1L3.oel", mimeType = "application/octet-stream")] public static const A1L3:Class;
		[Embed(source = "../levels/A1L4.oel", mimeType = "application/octet-stream")] public static const A1L4:Class;
		[Embed(source = "../levels/A1L5.oel", mimeType = "application/octet-stream")] public static const A1L5:Class;
	//ACT II	
		[Embed(source = "../levels/A2L1.oel", mimeType = "application/octet-stream")] public static const A2L1:Class;
		[Embed(source = "../levels/A2L2.oel", mimeType = "application/octet-stream")] public static const A2L2:Class;
	//ACT III
		[Embed(source = "../levels/A3L1.oel", mimeType = "application/octet-stream")] public static const A3L1:Class;
		[Embed(source = "../levels/A3L2.oel", mimeType = "application/octet-stream")] public static const A3L2:Class;
		[Embed(source = "../levels/A3L3.oel", mimeType = "application/octet-stream")] public static const A3L3:Class;
		[Embed(source = "../levels/A3L4.oel", mimeType = "application/octet-stream")] public static const A3L4:Class;
	//ACT IV
		[Embed(source = "../levels/A4.oel", mimeType = "application/octet-stream")] public static const A4:Class;
		
	//Sfx
		//Player
		[Embed(source = "../assets/Sfx/Bloodhoseshoot.mp3")] public static const PL_SHOOT:Class;
		[Embed(source = "../assets/Sfx/PLbloodcollect_01.mp3")] public static const PL_BLOODCOLLECT:Class;
		[Embed(source = "../assets/Sfx/PLDeath_01.mp3")] public static const PL_DEATH:Class;
		[Embed(source = "../assets/Sfx/PLfruit_01.mp3")] public static const PL_FRUITCOLLECT:Class;
		[Embed(source = "../assets/Sfx/PLHurt_01.mp3")] public static const PL_HURT:Class;
		//Creatures
		[Embed(source = "../assets/Sfx/CreatureHurt_01.mp3")] public static const CR_DEATH:Class;
		[Embed(source = "../assets/Sfx/S_movement_01.mp3")] public static const S_MOVE:Class;
		[Embed(source = "../assets/Sfx/FS_movementr_01.mp3")] public static const FS_MOVE:Class;
		[Embed(source = "../assets/Sfx/FattleSHurt_01.mp3")] public static const FS_HURT:Class;
		[Embed(source = "../assets/Sfx/MonsterDeath_01.mp3")] public static const MS_HURT:Class;
		[Embed(source = "../assets/Sfx/MonsterDeath_01.mp3")] public static const MS_DEATH:Class;
		[Embed(source = "../assets/Sfx/OwlHurt_01.mp3")] public static const OWL_HURT:Class;
		[Embed(source = "../assets/Sfx/OWL_BG.mp3")] public static const OWL_BG:Class;
		[Embed(source = "../assets/Sfx/Snail_Cry_01.mp3")] public static const SNAIL_CRY:Class;
		//Pires
		[Embed(source = "../assets/Sfx/PireFed_01.mp3")] public static const PIRE_FED:Class;
	//Music	
		[Embed(source = "../assets/Music/Titlescreen_Music.mp3")] public static const TITLE_MUSIC:Class;
		[Embed(source = "../assets/Music/D1_Music.mp3")] public static const D1_MUSIC:Class;
		[Embed(source = "../assets/Music/D2_Music.mp3")] public static const D2_MUSIC:Class;
		[Embed(source = "../assets/Music/D3_music.mp3")] public static const D3_MUSIC:Class;
		[Embed(source = "../assets/Music/D4_Music.mp3")] public static const D4_MUSIC:Class;
		[Embed(source = "../assets/Music/D5_Music.mp3")] public static const D5_MUSIC:Class;
	//level sfx
		[Embed(source = "../assets/Music/A1.mp3")] public static const A1_SFX:Class;
		[Embed(source = "../assets/Music/A1L1.mp3")] public static const A1L1_SFX:Class;
		[Embed(source = "../assets/Music/A2.mp3")] public static const A2_SFX:Class;
		[Embed(source = "../assets/Music/A3.mp3")] public static const A3_SFX:Class;
		[Embed(source = "../assets/Music/Cavern.mp3")] public static const CAVERN_SFX:Class;
	}

}