package com.takumus.ui.list
{
	import a24.tween.Tween24;

	public class SortableCell extends Cell{
		//sort用
		private var _isLower:Boolean;
		private var _sortOffsetYTween:Tween24;
		internal var useForSort:Boolean;
		public function SortableCell(list:List):void
		{
			super(list);
		}
		protected final function sortStart():void
		{
			if(useForSort) return;
			_list._cell_startSort(data.id, cellId);
		}
		internal function _setSortPosition(isLower:Boolean, animate:Boolean = false):void
		{
			if(_isLower == isLower) return;
			_isLower = isLower;
			var y:Number = _isLower?cellHeight:0;
			
			if(_sortOffsetYTween) _sortOffsetYTween.stop();
			if(!animate){
				contents.y = y;
				return;
			}
			_sortOffsetYTween = Tween24.tween(contents, 0.1).y(y);
			_sortOffsetYTween.play();
		}
	}
}