package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import com.takumus.ui.list.List;
	
	[SWF(frameRate="60")]
	public class Sample extends Sprite
	{
		private var _list:List;
		public function Sample()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_list = new List(SampleCell);
			_list.y = 100;
			addChild(_list);
		}
	}
}