package
{
	import com.takumus.ui.list.List;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="60")]
	public class Sample extends Sprite
	{
		private var _list:List;
		public function Sample()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_list = new List(SampleCell, 60);
			addChild(_list);
			
			this.stage.addEventListener(Event.RESIZE, function(e:Event):void
			{
				_list.resize(stage.stageWidth, stage.stageHeight / 2);
				_list.y = stage.stageHeight / 4;
			});
		}
	}
}