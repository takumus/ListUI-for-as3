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
			
			init();
		}
		
		private function init():void
		{
			//リスト作成
			_list = new List(SampleCell, 60);
			addChild(_list);
			
			//データ準備
			var data:Array = [];
			for(var i:int = 0; i < 300; i ++){
				data.push("data" + i);
			}
			//リストにデータ適用
			_list.setData(data);
			
			//ステージの大きさに合わせてリサイズ
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