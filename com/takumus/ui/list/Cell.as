package com.takumus.ui.list
{
	import flash.display.Sprite;

	public class Cell extends Sprite{
		//セルの大きさ
		private var _cellHeight:Number, _cellWidth:Number;
		
		private var _data:CellData;
		protected var contents:Sprite;
		protected var _list:List;
		internal var cellId:int;
		public function Cell(list:List):void
		{
			this._list = list;
			this.contents = new Sprite();
			this.addChild(contents);
		}
		public final function get data():CellData
		{
			return _data;
		}
		public final function get dataId():int
		{
			return data.id;
		}
		
		protected function setData(data:CellData):void
		{	
		}
		protected function resize(width:Number, height:Number):void
		{
		}
		protected function dispose():void
		{
			
		}
		protected final function scrollStart():void
		{
			_list._cell_startScroll();
		}
		protected final function get cellHeight():Number
		{
			return _cellHeight;
		}
		protected final function get cellWidth():Number
		{
			return _cellWidth;
		}
		
		internal function _dispose():void
		{
			dispose();
		}
		internal function _setData(data:CellData):void
		{
			_data = data;
			setData(data);
		}
		internal function _resize(width:Number, height:Number):void
		{
			_cellWidth = width;
			_cellHeight = height;
			
			resize(width, height);
		}
		internal function get _yForSort():Number{
			return this.y + contents.y;
		}
	}
}