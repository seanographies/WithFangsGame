package  
{
	import chars.Alien;
	import chars.Dracula;
	import chars.FattleSnake;
	import chars.Monster;
	import chars.Owl;
	import chars.PireA;
	import chars.PireAB;
	import chars.PireB;
	import chars.Player;
	import chars.Psyche;
	import chars.Snail;
	import chars.Snake;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.Entity
	import net.flashpunk.masks.Grid;
	import objs.ArenaExit;
	import objs.BloodMoon;
	import objs.Button;
	import objs.CavernExit;
	import objs.CavernFruit;
	import objs.Fruits;
	import objs.InvisibleBlock;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import objs.TitleScreen;

	
	/**
	 * ...
	 * @author sean singh
	 */
	public class GameWorld extends World 
	{
		//Grid8
		protected var map:Entity;
		public var _mapGrid:Grid;
		public var _mapImage:Image;
		protected var _mapData:Class;
		
		//Tiles
		protected var tiles:Entity;
		public var _tilesGrid:Grid;
		public var _tilesImage:Image;
		
		protected var arrow:Player;
		protected var gm:GameManager = new GameManager;
		
		protected var testUrl:URLRequest = new URLRequest("http://www.google.com");
		
		protected var music:Sfx = new Sfx(GA.TITLE_MUSIC);
		
		public function GameWorld(mapData:Class) 
		{
			_mapData = mapData;
			super(); 
			loadMap(_mapData);
          
			_mapImage = new Image(_mapGrid.data);
			_mapImage.color = 0x000000;
			_mapImage.scale = 4;
           map = new Entity (_mapGrid.x ,_mapGrid.y, _mapImage, _mapGrid);
		   map.setHitbox(_mapGrid.width,_mapGrid.height);
		   map.type = "level";			
		   map.layer = 11; 
		}
		
		override public function begin():void {
			super.begin();
			gm.updateDraculaLevel();
			changeBackground();
			add(map);
			add(arrow);
			updateCavernFruits();
			trace("LEVEL_TICKET =  " + GameManager.LEVEL_TICKET);
		}
		
		
		//loads levels
		protected function loadMap(mapData:Class):void {
			var mapXML:XML = FP.getXML(mapData);
			var node:XML;
			
			//map grid	
            _mapGrid = new Grid(uint(mapXML.@width), (uint(mapXML.@height)), 4,4,0,0);
            _mapGrid.loadFromString(String(mapXML.Grid4), "", "\n");
			//chars
			for each (node in mapXML.Entities.PireAB) {
				add(new PireAB (Number(node.@x), Number(node.@y)));
			}
			for each (node in mapXML.Entities.PireA) {
				add(new PireA (Number(node.@x),Number(node.@y)));
			}
			for each (node in mapXML.Entities.PireB) {
				add(new PireB (Number(node.@x),Number(node.@y)));
			}			
			
			arrow = new Player(new Point(Number (mapXML.Entities.Plyr.@x), (Number(mapXML.Entities.Plyr.@y))));	
			
			for each (node in mapXML.Entities.Snake) {
				add(new Snake(Number(node.@x), Number(node.@y),100));
			}			
			for each (node in mapXML.Entities.SnakeH) {
				add(new Snake(Number(node.@x), Number(node.@y),100,100,true));
			}
			for each (node in mapXML.Entities.FSnake) {
				add(new FattleSnake(Number(node.@x), Number(node.@y), true, false, 180, 100, 100));
			}			
			for each (node in mapXML.Entities.FSnakeHH) {
				add(new FattleSnake(Number(node.@x), Number(node.@y), true, false, 180, 100, 100,true));
			}			
			for each (node in mapXML.Entities.FSnakeV) {
				add(new FattleSnake(Number(node.@x), Number(node.@y), false, true, 180, 200, 100));
			}			
			for each (node in mapXML.Entities.FSnakeVH) {
				add(new FattleSnake(Number(node.@x), Number(node.@y), false, true, 180, 200, 100,true));
			}			
			for each (node in mapXML.Entities.Owl) {
				add(new Owl(Number(node.@x),Number(node.@y),50,300));
			}			
			for each (node in mapXML.Entities.OwlH) {
				add(new Owl(Number(node.@x),Number(node.@y),50,200,true));
			}
			for each (node in mapXML.Entities.Psyche) {
				add(new Psyche (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.Alien) {
				add(new Alien (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.Snail) {
				add(new Snail (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.Monster) {
				add(new Monster (Number(node.@x), Number(node.@y)));
			}
			for each (node in mapXML.Entities.Dracula) {
				add(new Dracula(Number(node.@x), Number(node.@y)));
			}	
			
		//objects
			for each (node in mapXML.Entities.Fruits) {
				add(new Fruits (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.CavernExit) {
				add(new CavernExit (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.ArenaExit) {
				add(new ArenaExit (Number(node.@x), Number(node.@y)));
			}
			//circles
			for each (node in mapXML.Entities.Circle256) {
				_tilesImage = new Image(GA.CIR256);
				tiles = new Entity(Number(node.@x), Number(node.@y), _tilesImage);
				tiles.layer = 10;
				add(tiles);
			}
			for each (node in mapXML.Entities.Circle128) {
				_tilesImage = new Image(GA.CIR128);
				tiles = new Entity(Number(node.@x), Number(node.@y), _tilesImage);
				tiles.layer = 10;
				add(tiles);
			}
			for each (node in mapXML.Entities.Circle64) {
				_tilesImage = new Image(GA.CIR64);
				tiles = new Entity(Number(node.@x), Number(node.@y), _tilesImage);
				tiles.layer = 10;
				add(tiles);
			}			
			for each (node in mapXML.Entities.CavernCircle) {
				_tilesImage = new Image(GA.CIR256);
				_tilesImage.centerOO();
				_tilesImage.scale = 2.5;
				tiles = new Entity(Number(node.@x), Number(node.@y), _tilesImage);
				tiles.layer = 10;
				add(tiles);
			}
			for each (node in mapXML.Entities.Invisibleblocks) {
				add(new InvisibleBlock (Number(node.@x), Number(node.@y)));
			}			
			for each (node in mapXML.Entities.Bloodmoon) {
				add(new BloodMoon (Number(node.@x), Number(node.@y)));
			}
		//tiles
			for each (node in mapXML.Entities.Coldhands) {
				var coldhands:Image = new Image(GA.COLDHAND);
				coldhands.centerOO();
				coldhands.scale = 2;
				var coldhandse:Entity = new Entity(Number(node.@x), Number(node.@y), coldhands);
				coldhandse.layer = 10;
				add(coldhandse);
			}	
			for each (node in mapXML.Entities.Coldhand) {
				var coldhand:Image = new Image(GA.COLDHAND);
				coldhand.centerOO();
				coldhand.scale = 14;
				var coldhande:Entity = new Entity(Number(node.@x), Number(node.@y), coldhand);
				coldhande.layer = 10;
				add(coldhande);
			}	
			for each (node in mapXML.Entities.Draculacircle) {
				var Draculacircle:Image = new Image(GA.DCIRCLE);
				Draculacircle.centerOO();
				Draculacircle.scale = 4;
				var draculae:Entity = new Entity(Number(node.@x), Number(node.@y), Draculacircle);
				draculae.layer = 10;
				add(draculae);
			}
			for each (node in mapXML.Entities.deadfather) {
				var deadFather:Image = new Image(GA.DEAD_FATHER);
				deadFather.centerOO();
				var dfe:Entity = new Entity(Number (node.@x), Number(node.@y), deadFather);
				dfe.layer = 2;
				add(dfe);
			}
			for each (node in mapXML.Entities.Titlescreen) {
				GV.titleScreen = true;
				add(new TitleScreen());
				add(new Button(32, 544,"Seanographies","http://www.seanographies.tumblr.com"));
			}
			//if (String(mapXML.Tiles16).length > 0) {
				//var tm:Tilemap = new Tilemap(GA.TILES, _mapGrid.width, _mapGrid.height, 16, 16);
				//tm.loadFromString(mapXML.Tiles16, ",","\n");
				//save tilemap as the map image.
				//_mapImage = tm;
			//}			
		}
		
		//spawns fruits in Cavern according to fruit collected in arena, resets fruits collected after execution
		protected function updateCavernFruits():void {
				var originX:int = 205;
				var originY:int = 320;
				var originx2:int = 150;
				var originy2:int = 420;
			if (GV.cavernLevel == true) {
				for (var i:int = 0; i <= GV.fruitsCollected; i++) {
					if (i <=6 && i > 0) {
						originX += 50;
						add(new CavernFruit(originX, originY));
					}					
					if (i >6) {
						originx2 += 50;
						add(new CavernFruit(originx2, originy2));
					}
				}
				GV.fruitsCollected = 0;
			}
		}
		
		//changes levels background
		public function changeBackground():void {
			var background:Image;
			var layerN:int = 100;
			
			if (GameManager.LEVEL_TICKET == 2) {
				background = new Image(GA.BGA1L1);
			}			if (GameManager.LEVEL_TICKET == 4) {
				background = new Image(GA.BGA1L2);
			}			if (GameManager.LEVEL_TICKET == 6) {
				background = new Image(GA.BGA1L3);
			}if (GameManager.LEVEL_TICKET == 7) {
				background = new Image(GA.BGA1L4);
			}				if (GameManager.LEVEL_TICKET == 9) {
				background = new Image(GA.BGA1L5);
			}				if (GameManager.LEVEL_TICKET == 10) {
				background = new Image(GA.BGA2L1);
			}				if (GameManager.LEVEL_TICKET == 11) {
				background = new Image(GA.BGA2L2);
			}				if (GameManager.LEVEL_TICKET == 12) {
				background = new Image(GA.BGA3L1);
			}				if (GameManager.LEVEL_TICKET == 13) {
				background = new Image(GA.BGA3L2);
			}				if (GameManager.LEVEL_TICKET == 15) {
				background = new Image(GA.BGA3L3);
			}				if (GameManager.LEVEL_TICKET == 16) {
				background = new Image(GA.BGA4);
			}				if (GameManager.LEVEL_TICKET == 17) {
				background = new Image(GA.E1);
				layerN = 2;
			}				if (GameManager.LEVEL_TICKET == 18) {
				background = new Image(GA.E2);
				layerN = 2;
			}				if (GameManager.LEVEL_TICKET == 19) {
				background = new Image(GA.E3);
				layerN = 2;
			}				if (GameManager.LEVEL_TICKET == 20) {
				background = new Image(GA.E4);
				layerN = 2;
			}				if (GameManager.LEVEL_TICKET == 21) {
				background = new Image(GA.E5);
				layerN = 0;
			}				if (GameManager.LEVEL_TICKET == 22) {
				add(new Button(32, 544,"Seanographies","http://www.seanographies.tumblr.com"));
				add(new Button(325, 256,"Resources","http://seanographies.tumblr.com/withfangs",32));
				background = new Image(GA.BGCREDITS);
				layerN = 1;
				FP.world.remove(arrow);
			}					
			
			
			if (GV.cavernLevel == true) {
				background = new Image(GA.BGCAVERN);
			}
			
			var e:Entity = new Entity;
			e.graphic = background;
			e.layer = layerN;
			add(e);
		}
		
	}

}