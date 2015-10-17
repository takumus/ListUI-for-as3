package
{
	import com.takumus.ui.list.List;
	
	import flash.display.Shape;
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
			
			var listArea:Shape = new Shape();
			_list = new List(SampleCell, 60);
			
			var data:Array = [];
			for(var i:int = 0; i < 300; i ++){
				data.push("data" + i);
			}
			
			_list.setData(data);
			addChild(_list);
			addChild(listArea);
			
			this.stage.addEventListener(Event.RESIZE, function(e:Event):void
			{
				_list.resize(stage.stageWidth, stage.stageHeight / 2);
				_list.y = stage.stageHeight / 4;
				
				listArea.graphics.clear();
				listArea.graphics.beginFill(0xff0000, 0.3);
				listArea.graphics.drawRect(0, 0, stage.stageWidth, _list.y);
				listArea.graphics.endFill();
				
				listArea.graphics.beginFill(0xff0000, 0.3);
				listArea.graphics.drawRect(0, stage.stageHeight / 2 + _list.y, stage.stageWidth, _list.y);
				listArea.graphics.endFill();
			});
		}
	}
}