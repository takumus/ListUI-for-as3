package com.takumus.ui.list
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		private var _width:Number = 100, _height:Number = 100;
		
		private var _data:Vector.<CellData>;
		private var _cell:Vector.<SortableCell>;
		private var _cellListSize:int;
		private var _cellHeight:Number = 60;
		
		private var _topY:Number = 0;
		private var _topId:int = 0;
		
		private var _mode:String;
		private var _mouseY:Number;
		
		private var _cellForSort:SampleCell;
		private var _sortInsertId:int = 0;
		
		private var CellClass:Class;
		public function List(CellClass:Class, cellHeight:Number)
		{
			super();
			
			this.CellClass = CellClass;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
			_data = new Vector.<CellData>();
			_cell = new Vector.<SortableCell>();
			
			_cellHeight = cellHeight;
			
			_cellForSort = new CellClass(this);
			_cellForSort.visible = false;
			addChild(_cellForSort);
			
			for(var i:int = 0; i < 100; i ++){
				var cd:CellData = new CellData();
				cd.data = "データ"+i;
				cd.id = i;
				_data.push(cd);
			}
		}
		public function resize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			
			//前のセル数
			var prevCellListSize:int = _cellListSize;
			//今のセル数
			_cellListSize = _height / _cellHeight + 1;
			
			//画面を覆うだけのcellを準備
			for(var i:int = 0; i < _cellListSize; i ++){
				//もともとあったらスキップ
				if(i < prevCellListSize) continue;
				//無かったら作成
				var cell:SortableCell = new CellClass(this);
				_cell.push(cell);
				addChild(cell);
				cell._resize(_width, _cellHeight);
			}
			//ソート用のセルをリサイズ
			_cellForSort._resize(_width, _cellHeight);
			
		}
		private function mouseMove(event:MouseEvent):void
		{
			if(_mode == "scroll"){
				_topY += stage.mouseY - _mouseY;
				_mouseY = stage.mouseY;
			}else if(_mode == "sort"){
			}
		}
		private function mouseUp(event:MouseEvent):void
		{
			if(_mode == "scroll"){
				stopScroll();
			}else if(_mode == "sort"){
				stopSort();
			}
		}
		private function update(event:Event):void
		{
			if(_mode == "scroll"){
				
			}else if(_mode == "sort"){
				_cellForSort.y = mouseY - _cellHeight * 0.5;
			}
			
			var tmpTopId:int = -_topY / _cellHeight;
			var topIdV:int = tmpTopId - _topId;
			_topId = tmpTopId;
			optimizeCells(topIdV);
			
			var scY:Number = _cellForSort.y;
			_sortInsertId = -1;
			for(var i:int = 0; i < _cell.length; i ++){
				var id:int = i + _topId;
				_cell[i]._setData(_data[id]);
				_cell[i].y = _topY%_cellHeight + i * _cellHeight;
				_cell[i].cellId = i;
				//ソートモードの場合
				if(_mode == "sort"){
					trace(_cell[i]._yForSort);
					if(scY < _cell[i]._yForSort){
						if(_sortInsertId < 0){
							_sortInsertId = _cell[i].data.id;
						}
						_cell[i]._setSortPosition(true, true);
					}else{
						_cell[i]._setSortPosition(false, true);
					}
				}
			}
		}
		//----------------------------------------------------------//
		//スクロール
		//----------------------------------------------------------//
		private function startScroll():void
		{
			_mode = "scroll";
			start();
		}
		private function stopScroll():void
		{
			stop();
		}
		//----------------------------------------------------------//
		//ソート
		//----------------------------------------------------------//
		private function startSort(dataId:int, cellId:int):void
		{
			_mode = "sort";
			_cellForSort._setData(_data.removeAt(dataId));
			updateCellDataId();
			_cellForSort.visible = true;
			_cellForSort.y = mouseY;
			
			for(var i:int = cellId; i < _cell.length; i ++){
				_cell[i]._setSortPosition(true, false);
			}
			start();
		}
		private function stopSort():void
		{
			_data.insertAt(_sortInsertId, _cellForSort.data);
			for(var i:int = 0; i < _cell.length; i ++){
				_cell[i]._setSortPosition(false, false);
			}
			for(var i:int = 0; i < _data.length; i ++){
				_data[i].id = i;
			}
			_cellForSort.visible = false;
			stop();
		}
		//----------------------------------------------------------//
		//共通
		//----------------------------------------------------------//
		private function start():void
		{
			_mouseY = stage.mouseY;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function stop():void
		{
			_mode = "none";
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function optimizeCells(idV:int):void
		{
			var i:int = 0
			if(idV > 0){
				for(i = 0; i < idV; i ++){
					_cell.push(_cell.shift());
				}
			}else if(idV < 0){
				idV = -idV;
				for(i = 0; i < idV; i ++){
					_cell.unshift(_cell.pop());
				}
			}
		}
		private function updateCellDataId():void
		{
			for(var i:int = 0; i < _data.length; i ++){
				_data[i].id = i;
			}
		}
		
		//セルからのアクション
		internal function _cell_startSort(dataId:int, cellId:int):void
		{
			startSort(dataId, cellId);
		}
		internal function _cell_startScroll():void
		{
			startScroll();
		}
	}
}