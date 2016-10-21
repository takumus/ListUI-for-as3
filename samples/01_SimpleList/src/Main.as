package
{
	import com.takumus.ui.events.ListEvent;
	import com.takumus.ui.list.List;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	
	[SWF(frameRate="60")]
	public class Main extends Sprite
	{
		private var _list:List;
		private var _textField:TextField;
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			init();
		}
		
		private function init():void
		{	
			//create List
			_list = new List(SampleCell, 60);
			addChild(_list);
			
			//create traceTextField
			_textField = new TextField();
			_textField.background = true;
			_textField.border = true;
			addChild(_textField);
			
			//create Data
			var data:Array = [];
			for(var i:int = 0; i < 50; i ++){
				data.push("data" + i);
			}
			
			//set data to List
			_list.setData(data);
			
			//add message event
			_list.addEventListener(ListEvent.MESSAGE, function(e:ListEvent):void
			{
				_textField.text = e.cellData.data + ":" + e.data;
			});
			
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
			_textField.width = stage.stageWidth/2;
		}
	}
}