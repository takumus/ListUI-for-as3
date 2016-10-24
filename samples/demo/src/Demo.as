package
{
	import com.takumus.ui.events.ListEvent;
	import com.takumus.ui.list.List;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(frameRate="60")]
	public class Demo extends Sprite
	{
		private var _list:List;
		private var _log:TextField;
		public function Demo()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		
		private function init():void
		{
			_list = new List(SimpleCell, 50, 0, new SimpleScrollBar());
			addChild(_list);
			
			//add data to list
			_list.setData("ABCDEGFHIJKLMNOPQRSTU".split(""));
			
			//add message event from cell
			_list.addEventListener(ListEvent.MESSAGE, function(event:ListEvent):void{
				log("message : {id:"+event.cellData.id + ", message:\"" + event.message + "\"}\n");
			});
			//add update event
			_list.addEventListener(ListEvent.UPDATE, function(event:ListEvent):void{
				log("updated : [");
				var tmpData:Array = _list.getData();
				for(var i:int = 0; i < tmpData.length; i ++){
					var data:String = tmpData[i];
					log(data+",");
				}
				log("]\n");
			});
			//add remove event
			_list.addEventListener(ListEvent.REMOVE, function(event:ListEvent):void
			{
				log("removed : {id:"+event.cellData.id + ", data:" + event.cellData.data.toString() + "}\n");
			});
			
			//debug log
			_log = new TextField();
			_log.width = _log.height = 400;
			_log.alpha = 0.5;
			_log.wordWrap = true;
			_log.defaultTextFormat = new TextFormat("", 12, 0x000000);
			_log.mouseEnabled = false;
			_log.border = true;
			_log.background = true;
			addChild(_log);
			
			//resize
			this.stage.addEventListener(Event.RESIZE, function(e:Event):void
			{
				resize();
			});
			
			resize();
		}
		private function log(text:String):void
		{
			_log.appendText(text);
			_log.scrollV = _log.maxScrollV;
		}
		private function resize():void
		{
			_list.resize(stage.stageWidth, stage.stageHeight);
			_log.x = (stage.stageWidth - _log.width) / 2;
			_log.y = (stage.stageHeight - _log.height) / 2;
		}
	}
}