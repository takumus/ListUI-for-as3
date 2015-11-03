package com.takumus.ui.list
{
	import com.takumus.ui.events.ListEvent;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	internal class _Debugger extends Sprite
	{
		private var _log:TextField;
		private var _list:List;
		public function _Debugger(width:Number, height:Number, list:List)
		{
			super();
			_list = list;
			
			_log = new TextField();
			_log.defaultTextFormat = new TextFormat("Consolas");
			_log.border = true;
			_log.background = true;
			_log.alpha = 0.8;
			_log.width = width;
			_log.height = height;
			this.mouseEnabled = false;
			this.addChild(_log);
			
			initEvents();
		}
		private function initEvents():void
		{
			_list.addEventListener(ListEvent.REMOVE, function(e:ListEvent):void{
				add("remove{\n" +
					"  data : " + e.cellData.data + "\n" +
					"  id   : " + e.cellData.id + "\n" +
					"}");
			});
			_list.addEventListener(ListEvent.SELECT, function(e:ListEvent):void{
				add("select{\n" +
					"  data : " + e.cellData.data + "\n" +
					"  id   : " + e.cellData.id + "\n" +
					"}");
			});
			_list.addEventListener(ListEvent.UPDATE, function(e:ListEvent):void{
				add("updated{\n" +
					"}");
			});
		}
		public function add(log:String):void
		{
			if(!List._debug) return;
			_log.appendText(log + "\n");
			_log.scrollV = _log.maxScrollV;
		}
	}
}