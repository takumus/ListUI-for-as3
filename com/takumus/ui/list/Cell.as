package com.takumus.ui.list
{
	import flash.display.Sprite;

	public class Cell extends Sprite{
		private var _cellData:CellData;
		protected var contents:Sprite;
		protected var _list:List;
		internal var cellId:int;
		public function Cell(list:List):void
		{
			this._list = list;
			this.contents = new Sprite();
			this.addChild(contents);
		}
		internal function _setData(data:CellData):void
		{
			_cellData = data;
			setData(data);
		}
		public function get cellData():CellData
		{
			return _cellData;
		}
		protected function setData(data:CellData):void
		{
			
		}
		public function render(width:Number, height:Number):void
		{
			contents.graphics.clear();
			contents.graphics.lineStyle(1,0xCCCCCC);
			contents.graphics.beginFill(0xFFFFFF);
			contents.graphics.drawRect(0,0,width, height);
		}
		public function get contentY():Number{
			return this.y + contents.y;
		}
		protected function scrollStart():void
		{
			_list._cell_startScroll();
		}
		
		public function get dataId():int
		{
			return cellData.id;
		}
	}
}