package {
	import com.takumus.ui.list.ScrollBar;

	/**
	 * @author takumus
	 */
	public class SimpleScrollBar extends ScrollBar {
		public function SimpleScrollBar() {
			super(10, 50, 10);
		}
		protected override function render(width:Number, height:Number):void
		{
			body.graphics.clear();
			body.graphics.beginFill(0x000000, 0.8);
			body.graphics.drawRect(0, 0, width, height);
			body.graphics.endFill();
		}
	}
}
