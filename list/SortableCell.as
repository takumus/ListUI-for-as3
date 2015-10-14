package list
{
	import a24.tween.Tween24;

	public class SortableCell extends Cell{
		//sort用
		private var _sortLower:Boolean;
		private var _sortOffsetYTween:Tween24;
		internal var useForSort:Boolean;
		public function SortableCell(list:List):void
		{
			super(list);
		}
		internal function setSortPosition(isLower:Boolean, animate:Boolean = false):void
		{
			if(_sortLower == isLower) return;
			_sortLower = isLower;
			var y:Number = _sortLower?this.height:0;
			if(!animate){
				contents.y = y;
				return;
			}
			if(_sortOffsetYTween) _sortOffsetYTween.stop();
			_sortOffsetYTween = Tween24.tween(contents, 0.1).y(y);
			_sortOffsetYTween.play();
		}
		protected function sortStart():void
		{
			if(useForSort) return;
			_list._cell_startSort(cellData.id, cellId);
		}
	}
}