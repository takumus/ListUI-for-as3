package
{
	import flash.text.TextFormat;
	import flash.text.TextField;
	import com.takumus.ui.events.ListEvent;
	import com.takumus.ui.list.List;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="60")]
	public class Sample extends Sprite
	{
		private var _list:List;
		private var _log:TextField;
		public function Sample()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			init();
		}
		
		private function init():void
		{
			//リスト作成(セルクラス, セルの高さ, スクロールバー, デフォルトのモード)
			_list = new List(SampleCell, 60, new SampleScrollBar(), "edit");
			addChild(_list);
			
			//データ準備
			var data:Array = [];
			for(var i:int = 0; i < 50; i ++){
				data.push("data" + i);
			}
			
			//リストにデータ適用
			_list.setData(data);
			
			//リストにイベントを追加
			_list.addEventListener(ListEvent.SELECT, function(event:ListEvent):void{
				trace(event.cellData.data);
				_log.appendText(event.cellData.id + " : " + event.cellData.data.toString() + " clicked\n");
				_log.scrollV = _log.maxScrollV;
			});
			
			
			//リストをステージの大きさに合わせてリサイズ
			this.stage.addEventListener(Event.RESIZE, function(e:Event):void
			{
				updateSize();
			});
			
			//ログ系
			_log = new TextField();
			_log.defaultTextFormat = new TextFormat("", 12, 0x000000);
			addChild(_log);
			_log.border = true;
			_log.background = true;
			
			
			updateSize();
		}
		
		private function updateSize():void
		{
			_list.resize(stage.stageWidth, stage.stageHeight);
			_log.x = (stage.stageWidth - _log.width) / 2;
			_log.y = (stage.stageHeight - _log.height) / 2;
		}
	}
}