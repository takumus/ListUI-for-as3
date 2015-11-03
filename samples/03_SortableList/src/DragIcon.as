package
{
	import flash.display.Sprite;
	
	public class DragIcon extends Sprite{
		public function DragIcon(size:Number):void
		{
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawCircle(0, 0, size / 2);
			this.graphics.endFill();
			
			size *= 0.5;
			
			this.graphics.lineStyle(3, 0xffffff);
			this.graphics.moveTo(-size * 0.5, - size * 0.5);
			this.graphics.lineTo(size * 0.5, - size * 0.5);
			
			this.graphics.moveTo(-size * 0.5, 0);
			this.graphics.lineTo(size * 0.5, 0);
			
			this.graphics.moveTo(-size * 0.5, size * 0.5);
			this.graphics.lineTo(size * 0.5, size * 0.5);
		}
	}
}