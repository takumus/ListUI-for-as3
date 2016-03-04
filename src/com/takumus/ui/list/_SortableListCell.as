package com.takumus.ui.list
{
	import flash.events.Event;

	internal class _SortableListCell extends _ClickableListCell{
		//sort用
		private var _position:String;
		private var _useForSort:Boolean;
		private var _targetY:Number;
		private var _playing:Boolean;
		public function _SortableListCell(list:List):void
		{
			super(list);
		}
		protected final function beginSort():void
		{
			if(_useForSort) return;
			list._cell_beginSort(data.id, cellId);
		}
		public function set useForSort(val:Boolean):void
		{
			_useForSort = val;
		}
		internal function _setPosition(position:String, animate:Boolean = false):void
		{
			if(_position == position) return;
			_position = position;
			
			var y:Number;
			if(_position == "bottom"){
				y = cellHeight;
			}else if(_position == "center"){
				y = 0;
			}else{;
				y = -cellHeight;
			}
			_targetY = y;
			if(!animate){
				body.y = y;
				return;
			}
			
			stopAnimation();
			startAnimation();
		}
		internal function get _yForSort():Number
		{
			return _parent.y + body.y;
		}
		
		private function animation(event:Event):void
		{
			body.y += (_targetY - body.y)*0.4;
			var diff:Number = body.y - _targetY;
			diff *= diff<0?-1:1;
			if(diff < 1){
				body.y = _targetY;
				stopAnimation();
			}
		}
		private function startAnimation():void
		{
			body.addEventListener(Event.ENTER_FRAME, animation);
			_playing = true;
		}
		private function stopAnimation():void
		{
			if(_playing) body.removeEventListener(Event.ENTER_FRAME, animation);
			_playing = false;
		}
	}
}