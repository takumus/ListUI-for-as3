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
			//enable debug mode
			List._debug = true;
			
			
			//create List
			_list = new List(SampleCell, 60);
			addChild(_list);
			
			//create Data
			var data:Array = [];
			for(var i:int = 0; i < 10; i ++){
				data.push(i);
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