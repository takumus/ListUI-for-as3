package com.takumus.ui.list
{
	import a24.tween.Tween24;

	public class SortableCell extends Cell{
		//sort用
		private var _position:String;
		private var _sortOffsetYTween:Tween24;
		internal var useForSort:Boolean;
		public function SortableCell(list:List):void
		{
			super(list);
		}
		protected final function sortStart():void
		{
			if(useForSort) return;
			list._cell_startSort(data.id, cellId);
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
			
			if(_sortOffsetYTween) _sortOffsetYTween.stop();
			if(!animate){
				body.y = y;
				return;
			}
			_sortOffsetYTween = Tween24.tween(body, 0.2).y(y);
			_sortOffsetYTween.play();
		}
		internal function get _yForSort():Number
		{
			return _parent.y + body.y;
		}
	}
}