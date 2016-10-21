package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Button extends Sprite
	{
		private var _label:TextField;
		private var _background:uint;
		public function Button(background:uint, label:String)
		{
			super();
			_background = background;
			_label = new TextField();
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = label;
			this.addChild(_label);
		}
		public function resize(width:Number, height:Number):void
		{
			_label.x = width / 2 - _label.width / 2;
			_label.y = height / 2 - _label.height / 2;
			this.graphics.clear();
			this.graphics.beginFill(_background);
			var round:Number = (width < height ? width : height)*0.4;
			this.graphics.drawRoundRect(0, 0, width, height, round, round);
		}
	}
}