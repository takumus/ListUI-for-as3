package {
	import com.takumus.ui.list.ScrollBar;

	/**
	 * @author takumus
	 */
	public class SampleScrollBar extends ScrollBar {
		public function SampleScrollBar() {
			super(10, 50, 10);
		}
		public override function render(width:Number, height:Number):void
		{
			content.graphics.clear();
			content.graphics.beginFill(0x000000, 0.8);
			content.graphics.drawRect(0, 0, width, height);
			content.graphics.endFill();
		}
	}
}
