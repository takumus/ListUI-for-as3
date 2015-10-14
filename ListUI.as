package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import list.List;
	
	[SWF(frameRate="60")]
	public class ListUI extends Sprite
	{
		private var _list:List;
		public function ListUI()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_list = new List(MyCell);
			_list.y = 100;
			addChild(_list);
		}
	}
}