package
{
	import com.takumus.ui.list.List;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="60")]
	public class Main extends Sprite
	{
		private var _list:List;
		
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			init();
		}
		
		private function init():void
		{
			//create List
			//attach SampleBar to List
			_list = new List(SampleCell, 60, 0, new SampleBar());
			addChild(_list);
			
			//create Data
			var data:Array = [];
			for(var i:int = 0; i < 50; i ++){
				data.push("data" + i);
			}
			
			//set data to List
			_list.setData(data);
			
			//resize list to stage
			this.stage.addEventListener(Event.RESIZE, function(e:Event):void
			{
				updateSize();
			});
			updateSize();
		}
		
		private function updateSize():void
		{
			_list.resize(stage.stageWidth, stage.stageHeight);
		}
	}
}
