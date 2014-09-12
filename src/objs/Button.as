package objs 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Button extends Entity 
	{
		protected var text:Text;
		protected var myUrl:URLRequest;
		
		public function Button(_x:Number, _y:Number, _text:String, _url:String, _size:uint = 22) 
		{
			text = new Text(_text, x, y);
			this.x = _x;
			this.y = _y;
			text.size = _size;
			graphic = text;
			myUrl = new URLRequest(_url);
			setHitbox(text.width, text.height,0,0);
			layer = 0;
		}
		
		override public function update():void {
			if (collidePoint(x, y, Input.mouseX, Input.mouseY)) {
				Input.mouseCursor = MouseCursor.BUTTON;
				text.color =  0x3D5043;
				if (Input.mousePressed) {
					navigateToURL(myUrl,"_blank")
				}
			}else {
				text.color = 0x848A6B;
				Input.mouseCursor = MouseCursor.ARROW;
			}
		}
		
	}

}