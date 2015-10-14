package list
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		private var _height:Number;
		private var _data:Vector.<CellData>;
		private var _cell:Vector.<SortableCell>;
		private var _cellHeight:Number = 60;
		
		private var _topY:Number = 0;
		private var _topId:int = 0;
		
		private var _mode:String;
		private var _mouseY:Number;
		
		private var _sortCell:MyCell;
		private var _sortInsertId:int = 0;
		
		private var CellClass:Class;
		public function List(CellClass:Class)
		{
			super();
			
			this.CellClass = CellClass;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			_height = 800;
			this.graphics.lineStyle(1, 0xFF0000);
			this.graphics.drawRect(0, 0, 500, _height);
			
			_data = new Vector.<CellData>();
			_cell = new Vector.<SortableCell>();
			for(var i:int = 0; i < _height / _cellHeight + 1; i ++){
				var cell:SortableCell = new CellClass(this);
				_cell.push(cell);
				addChild(cell);
				cell.render(300, _cellHeight);
			}
			_sortCell = new CellClass(this);
			_sortCell.render(300, _cellHeight);
			_sortCell.visible = false;
			addChild(_sortCell);
			for(var i:int = 0; i < 100; i ++){
				var cd:CellData = new CellData();
				cd.data = "@"+i;
				cd.id = i;
				_data.push(cd);
			}
		}
		private function mouseMove(event:MouseEvent):void
		{
			if(_mode == "scroll"){
				_topY += stage.mouseY - _mouseY;
				_mouseY = stage.mouseY;
			}else if(_mode == "sort"){
				//_sortCell.y = mouseY;
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
				_sortCell.y = mouseY;
			}
			
			var tmpTopId:int = -_topY / _cellHeight;
			var topIdV:int = tmpTopId - _topId;
			_topId = tmpTopId;
			optimizeCells(topIdV);
			
			var scY:Number = _sortCell.y;
			_sortInsertId = -1;
			for(var i:int = 0; i < _cell.length; i ++){
				var id:int = i + _topId;
				_cell[i]._setData(_data[id]);
				_cell[i].y = _topY%_cellHeight + i * _cellHeight;
				_cell[i].cellId = i;
				//ソートモードの場合
				if(_mode == "sort"){
					trace(_cell[i].contentY);
					if(scY < _cell[i].contentY){
						if(_sortInsertId < 0){
							_sortInsertId = _cell[i].cellData.id;
						}
						_cell[i].setSortPosition(true, true);
					}else{
						_cell[i].setSortPosition(false, true);
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
			_sortCell._setData(_data.removeAt(dataId));
			updateCellDataId();
			_sortCell.visible = true;
			_sortCell.y = mouseY;
			
			for(var i:int = cellId; i < _cell.length; i ++){
				_cell[i].setSortPosition(true, false);
			}
			start();
		}
		private function stopSort():void
		{
			_data.insertAt(_sortInsertId, _sortCell.cellData);
			for(var i:int = 0; i < _cell.length; i ++){
				_cell[i].setSortPosition(false, false);
			}
			for(var i:int = 0; i < _data.length; i ++){
				_data[i].id = i;
			}
			_sortCell.visible = false;
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