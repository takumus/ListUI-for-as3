package com.takumus.ui.list
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		private var _width:Number = 100, _height:Number = 100;
		
		private var _dataList:Vector.<CellData>;
		private var _cellList:Vector.<SortableCell>;
		private var _cellListSize:int;
		private var _cellHeight:Number;
		
		private var _topY:Number = 0;
		private var _topId:int = 0;
		
		private var _mode:String;
		private var _mouseY:Number;
		
		private var _cellForSort:Cell;
		private var _sortInsertId:int = 0;
		
		private var CellClass:Class;
		public function List(CellClass:Class, cellHeight:Number)
		{
			super();
			
			this.CellClass = CellClass;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
			_dataList = new Vector.<CellData>();
			_cellList = new Vector.<SortableCell>();
			
			_cellHeight = cellHeight;
			
			_cellForSort = new CellClass(this);
			_cellForSort.visible = false;
			addChild(_cellForSort);
			
			for(var i:int = 0; i < 100; i ++){
				var cd:CellData = new CellData();
				cd.data = "データ"+i;
				cd.id = i;
				_dataList.push(cd);
			}
		}
		public function resize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			
			//前のセル数
			var prevCellListSize:int = _cellListSize;
			//今のセル数
			_cellListSize = int(_height / _cellHeight + 0.5) + 2;
			//セルの差
			var cellListSizeDiff:int = _cellListSize - prevCellListSize;
			
			var cell:SortableCell;
			var i:int;
			if(cellListSizeDiff > 0){
				//前よりもセルの数が多くなったら
				
				//その分を補う。
				for(i = 0; i < cellListSizeDiff; i ++){
					cell = new CellClass(this);
					_cellList.push(cell);
					addChild(cell);
				}
			}else if(cellListSizeDiff < 0){
				//前より少なくなったら
				
				//その分を消す。
				for(i = 0; i < -cellListSizeDiff; i ++){
					cell = _cellList.pop();
					removeChild(cell);
					cell._dispose();
					cell = null;
				}
			}
			
			//セル達をリサイズ
			for(i = 0; i < _cellListSize; i ++){
				_cellList[i]._resize(_width, _cellHeight);
			}
			//ソート用のセルをリサイズ
			_cellForSort._resize(_width, _cellHeight);
			
			//更新
			update(null);
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
			//先頭のデータid
			var tmpTopId:int = -_topY / _cellHeight;
			//データidの変化
			var topIdV:int = tmpTopId - _topId;
			_topId = tmpTopId;
			//idの変化からセルの並べ替え
			optimizeCells(topIdV);
			
			var scY:Number = _cellForSort.y;
			_sortInsertId = -1;
			for(var i:int = 0; i < _cellListSize; i ++){
				var id:int = i + _topId;
				_cellList[i]._setData(_dataList[id]);
				_cellList[i].y = _topY%_cellHeight + i * _cellHeight;
				_cellList[i].cellId = i;
				//ソートモードの場合
				if(_mode == "sort"){
					if(scY < _cellList[i]._yForSort){
						if(_sortInsertId < 0){
							_sortInsertId = _cellList[i].data.id;
						}
						_cellList[i]._setSortPosition(true, true);
					}else{
						_cellList[i]._setSortPosition(false, true);
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
			_cellForSort._setData(_dataList.removeAt(dataId));
			updateCellDataId();
			_cellForSort.visible = true;
			_cellForSort.y = mouseY;
			
			for(var i:int = cellId; i < _cellListSize; i ++){
				_cellList[i]._setSortPosition(true, false);
			}
			start();
		}
		private function stopSort():void
		{
			_dataList.insertAt(_sortInsertId, _cellForSort.data);
			var i:int;
			for(i = 0; i < _cellListSize; i ++){
				_cellList[i]._setSortPosition(false, false);
			}
			for(i = 0; i < _dataList.length; i ++){
				_dataList[i].id = i;
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
					_cellList.push(_cellList.shift());
				}
			}else if(idV < 0){
				idV = -idV;
				for(i = 0; i < idV; i ++){
					_cellList.unshift(_cellList.pop());
				}
			}
		}
		private function updateCellDataId():void
		{
			for(var i:int = 0; i < _dataList.length; i ++){
				_dataList[i].id = i;
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