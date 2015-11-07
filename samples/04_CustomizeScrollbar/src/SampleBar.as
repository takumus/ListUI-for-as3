package
{
	import com.takumus.ui.list.ScrollBar;
	
	public class SampleBar extends ScrollBar
	{
		public function SampleBar()
		{
			super(20);
		}
		override protected function render(width:Number, height:Number):void
		{
			//use content
			body.graphics.beginFill(0xff0000);
			body.graphics.drawRoundRect(0, 0, width, height, 20, 20);
			body.graphics.endFill();
		}
	}
}