package com.takumus.ui.list
{
	import com.takumus.ui.events.ListEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		private var _width:Number = 100, _height:Number = 100;
		
		private var _dataList:Vector.<CellData>;
		private var _cellList:Vector.<_SortableListCell>;
		private var _cellListSize:int;
		private var _dataListSize:int;
		private var _cellHeight:Number;
		private var _realCellHeight:Number;
		private var _topY:Number = 0;
		private var _topYV:Number = 0;
		private var _topYVList:Vector.<Number>;
		private var _topId:int = 0;
		private var _contentsHeight:Number = 0;
		
		private var _mode:String;
		private var _mouseY:Number;
		private var _prevMouseY:Number;
		private var _mouseYV:Number;
		
		private var _cellForSort:ListCell;
		private var _sortInsertId:int = 0;
		private var _freezeScrollSort:Boolean;
		
		private var _cellContainer:Sprite;
		
		private var CellClass:Class;
		
		private var _startScrollHeight:Number = 50;
		private var _minScrollSpeed:Number = 30;
		
		private var _scrollBar:ScrollBar;
		
		private var _cellMode:String;
		
		public static var _bounceBack:Boolean = false;
		public static var _debug:Boolean = false;
		
		private var _enabled:Boolean;
		
		private var _backgroundColor:uint;
		private var _backgroundVisible:Boolean;
		
		private var _debugger:_Debugger;
		private var _cellSpace:Number;
		public function List(CellClass:Class, cellHeight:Number = 50, cellSpace:Number = 0, scrollBar:ScrollBar = null, defaultCellMode:String = "default", backgroundVisible:Boolean = true, backgroundColor:uint = 0xffffff)
		{
			super();
			
			this.CellClass = CellClass;
			_cellSpace = cellSpace;
			this._backgroundColor = backgroundColor;
			this._backgroundVisible = backgroundVisible;
			
			_dataList = new Vector.<CellData>();
			_cellList = new Vector.<_SortableListCell>();
			
			_topYVList = new Vector.<Number>();
			
			_cellContainer = new Sprite();
			
			if(scrollBar) {
				_scrollBar = scrollBar;
			}else{
				_scrollBar = new ScrollBar(5, 50, 10);
			}
			
			_cellHeight = cellHeight;
			_realCellHeight = cellHeight + cellSpace;
			_cellForSort = new CellClass(this);
			_cellForSort._parent.visible = false;
			_cellForSort.useForSort = true;
			_cellMode = defaultCellMode;
			
			addChild(_cellContainer);
			addChild(_cellForSort._parent);
			
			addChild(_scrollBar._body);
			
			enabled = true;
			_mode = "none";
			
			if(_debug) {
				_debugger = new _Debugger(200, 200, this);
				this.addChild(_debugger);
			}
		}
		public function resize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			
			//前のセル数
			var prevCellListSize:int = _cellListSize;
			//今のセル数
			_cellListSize = int(_height / _realCellHeight + 0.5) + 2;
			//セルの差
			var cellListSizeDiff:int = _cellListSize - prevCellListSize;
			
			var cell:_SortableListCell;
			var i:int;
			if(cellListSizeDiff > 0){
				//前よりもセルの数が多くなったら
				
				//その分を補う。
				for(i = 0; i < cellListSizeDiff; i ++){
					cell = new CellClass(this);
					//セルのモードをセット（デフォルトモード）
					cell._setMode(_cellMode, true);
					_cellList.push(cell);
					_cellContainer.addChild(cell._parent);
				}
			}else if(cellListSizeDiff < 0){
				//前より少なくなったら
				
				//その分を消す。
				for(i = 0; i < -cellListSizeDiff; i ++){
					cell = _cellList.pop();
					_cellContainer.removeChild(cell._parent);
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
			
			//スクロールバー更新
			_scrollBar._body.x = _width - _scrollBar.width;
			_scrollBar.setViewHeight(_height);
			
			//背景描画
			if(_backgroundVisible) renderBackground(_width, _height);
		}
		public function setData(data:Array):void
		{
			_dataList.length = 0;
			for(var i:int = 0; i < data.length; i ++){
				var cd:CellData = new CellData();
				cd.data = data[i];
				cd.id = i;
				_dataList.push(cd);
			}
			_dataListSize = _dataList.length;
			
			changeDataSize();
			update(null);
			
			scrollPosition = 0;
		}
		public function addData(data:Object, first:Boolean = false):void
		{
			var cd:CellData = new CellData();
			cd.data = data;
			cd.id = _dataListSize;
			if(first){
				_dataList.unshift(cd);
				for(var i:int = 0; i < _dataList.length; i ++){
					_dataList[i].id = i;
				}
			}else{
				_dataList.push(cd);
			}
			_dataListSize = _dataList.length;
			changeDataSize();
		}
		public function setCellMode(mode:String, def:Boolean = false):void
		{
			_cellMode = mode;
			_cellForSort._setMode(mode, def);
			for(var i:int = 0; i < _cellList.length; i ++){
				//defモードでセット
				_cellList[i]._setMode(_cellMode, def);
			}
		}
		public function forceUpdateCell():void
		{
			for(var i:int = 0; i < _cellListSize; i ++){
				var id:int = i + _topId;
				if(id < _dataListSize) _cellList[i]._setData(_dataList[id], true);
			}
		}
		public function get scrolling():Boolean{
			return Math.abs(_topYV) > 1;
		}
		public function get cellMode():String
		{
			return _cellMode;
		}
		public function set enabled(value:Boolean):void
		{
			if(_enabled == value) return;
			_enabled = value;
			if(_enabled){
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				this.addEventListener(Event.ENTER_FRAME, update);
			}else{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				this.removeEventListener(Event.ENTER_FRAME, update);
			}
			
			_enabled = value;
		}
		public function get enabled():Boolean
		{
			return _enabled;
		}
		public function getData():Array
		{
			var data:Array = [];
			for(var i:int = 0; i < _dataListSize; i ++){
				data.push(_dataList[i].data);
			}
			return data;
		}
		public function getCell():Vector.<_SortableListCell>
		{
			return _cellList;
		}
		public function set scrollPosition(value:Number):void
		{
			if(scrollable){
				_topY = -value * (_contentsHeight-_height);
				_topYV = 0;
			}
		}
		public function get scrollPosition():Number
		{
			return -_topY / (_contentsHeight-_height);
		}
		public function get cellContainer():Sprite
		{
			return _cellContainer;
		}
		
		private function renderBackground(width:Number, height:Number):void
		{
			this.graphics.clear();
			this.graphics.beginFill(_backgroundColor);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
		private function mouseDown(event:MouseEvent):void
		{
			_prevMouseY = mouseY;
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			//マウスダウン時はデフォでscrollStartする。
			if(_mode == "none") startScroll();
		}
		private function mouseUp(event:MouseEvent):void
		{
			if(_mode == "scroll"){
				stopScroll();
			}else if(_mode == "sort"){
				stopSort();
			}
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function update(event:Event):void
		{
			_mouseYV = mouseY - _prevMouseY;
			if(_mode == "scroll"){
				//----------------------------------------//
				//指でつかんでスクロール中
				//----------------------------------------//
				_topYV = stage.mouseY - _mouseY;
				_topYVList.push(_topYV);
				if(_topY + _topYV > 0 || !scrollable){
					_topYV *= 0.5;
					if(!_bounceBack){
						_topY = 0;
						_topYV = 0;
					}
				}else if(_topY + _topYV < -_contentsHeight + _height){
					_topYV *= 0.5;
					if(!_bounceBack){
						_topY = -_contentsHeight + _height;
						_topYV = 0;
					}
				}else{
					
				}
				_mouseY = stage.mouseY;
				_topY += _topYV;
			}else if(_mode == "sort"){
				//----------------------------------------//
				//指でつかんでソート中
				//----------------------------------------//
				_cellForSort._parent.y = mouseY - _cellHeight * 0.5;
				
				var scrollSpeed:Number = _contentsHeight / _height * 2;
				var scrollSpeedPer:Number = 0;
				var tmpMouseY:Number = 0;
				if(scrollSpeed < _minScrollSpeed){
					scrollSpeed = _minScrollSpeed;
				}
				if(mouseY < _startScrollHeight){
					tmpMouseY = _startScrollHeight - mouseY;
					scrollSpeedPer = tmpMouseY / _startScrollHeight;
					if(_mouseYV < 0) _freezeScrollSort = false;
				}else if(mouseY > _height - _startScrollHeight){
					tmpMouseY = mouseY - (_height - _startScrollHeight);
					scrollSpeedPer = -tmpMouseY / _startScrollHeight;
					if(_mouseYV > 0) _freezeScrollSort = false;
				}
				if(_freezeScrollSort) scrollSpeedPer = 0;
				
				scrollSpeed *= scrollSpeedPer;
				_topYV = scrollSpeed;
				_topY += _topYV;
				
				if(_topY > 0 || !scrollable){
					_topY  = 0;
					_topYV = 0;
				}else if(_topY < -_contentsHeight + _height){
					_topY = -_contentsHeight + _height;
					_topYV = 0;
				}
			}else{
				//----------------------------------------//
				//指を離して慣性の法則働き中
				//----------------------------------------//
				_topY += _topYV;
				var fixV:Boolean = false;
				if(_topY > 0 || !scrollable){
					_topY += (0 - _topY) * 0.15;
					
					if(_topYV > 0 || !scrollable) fixV = true;
					if(!_bounceBack){
						_topY = 0;
						_topYV = 0;
					}
				}else if(_topY < -_contentsHeight + _height){
					_topY += (-_contentsHeight + _height - _topY) * 0.15;
					
					if(_topYV < 0) fixV = true;
					if(!_bounceBack){
						_topY = -_contentsHeight + _height;
						_topYV = 0;
					}
				}
				if(fixV){
					//逆らう加速度だったら、加速度減らす。
					_topYV += (0 - _topYV) * 0.3;
				}else{
					_topYV *= 0.98;
				}
			}
			
			//先頭のデータid
			var tmpTopId:int = -_topY / _realCellHeight;
			//データidの変化
			var topIdV:int = tmpTopId - _topId;
			_topId = tmpTopId;
			//idの変化からセルの並べ替え
			optimizeCells(topIdV);
			
			//高速スクロール時は、ソートのアニメーションをしないよ！
			var needAnimation:Boolean = (_topYV<0?-_topYV:_topYV) < _realCellHeight;
			
			var scY:Number = _cellForSort._parent.y;
			_sortInsertId = _topId;
			for(var i:int = 0; i < _cellListSize; i ++){
				var id:int = i + _topId;
				
				if(id < 0 || id >= _dataListSize) {
					_cellList[i]._parent.visible = false;
					continue;
				}else{
					_cellList[i]._parent.visible = true;
				}
				
				_cellList[i]._setData(_dataList[id], false);
				_cellList[i]._parent.y = _cellSpace + _topY%_realCellHeight + i * (_realCellHeight);
				_cellList[i].cellId = i;
				//ソートモードの場合
				if(_mode == "sort"){
					if(scY < _cellList[i]._yForSort){
						_cellList[i]._parent.y += _cellSpace;
						//下へずらす
						_cellList[i]._setPosition("bottom", needAnimation);
					}else{
						//上へずらす
						_cellList[i]._setPosition("center", needAnimation);
						_sortInsertId = _cellList[i].data.id + 1;
					}
				}
			}
			
			
			//スクロールバー移動
			_scrollBar.setContentY(_topY);
		}
		private function get scrollable():Boolean
		{
			return _contentsHeight > _height;
		}
		//----------------------------------------------------------//
		//選択
		//----------------------------------------------------------//
		private function messageFromCell(dataId:int, data:Object = null):void
		{
			var e:ListEvent = new ListEvent(ListEvent.MESSAGE);
			e.cellData = _dataList[dataId];
			e.data = data;
			e.message = data;
			dispatchEvent(e);
		}
		//----------------------------------------------------------//
		//削除
		//----------------------------------------------------------//
		private function remove(dataId:int, cellId:int):void
		{
			var e:ListEvent = new ListEvent(ListEvent.REMOVE);
			e.cellData = _dataList.splice(dataId, 1)[0];
			_dataListSize = _dataList.length;
			updateDataListId();
			var i:int;
			
			if(_topY - 5 < -_contentsHeight + _height && scrollable){
				//一番下へ行っている
				for(i = 0; i < cellId; i ++){
					//対象以降を下へずらす
					_cellList[i]._setPosition("top", false);
					//上へ戻す
					_cellList[i]._setPosition("center", true);
				}
			}else{
				//一番下へ行っていない
				for(i = cellId; i < _cellListSize; i ++){
					//対象以降を下へずらす
					_cellList[i]._setPosition("bottom", false);
					//上へ戻す
					_cellList[i]._setPosition("center", true);
				}
			}
			changeDataSize();
			update(null);
			
			dispatchEvent(e);
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
			//加速度をframe分の平均をとって計算
			_topYVList.reverse();
			_topYV = 0;
			var frame:int = 5;
			var length:int = _topYVList.length<frame?_topYVList.length:frame;
			for(var i:int = 0; i < length; i ++){
				_topYV += _topYVList[i];
			}
			_topYVList.length = 0;
			_topYV /= length;
			if(isNaN(_topYV)) _topYV = 0;
			stop();
		}
		//----------------------------------------------------------//
		//ソート
		//----------------------------------------------------------//
		private function beginSort(dataId:int, cellId:int):void
		{
			_mode = "sort";
			var data:CellData = _dataList[dataId];
			_cellForSort._setData(data, true);		
			_dataList.splice(dataId, 1);
			
			_dataListSize = _dataList.length;
			updateDataListId();
			_cellForSort._parent.visible = true;
			_cellForSort._parent.y = mouseY;
			
			for(var i:int = cellId; i < _cellListSize; i ++){
				//対象以降を下へずらす
				_cellList[i]._setPosition("bottom", false);
			}
			_freezeScrollSort = true;
			start();
			update(null);
		}
		private function stopSort():void
		{
			_dataList.insertAt(_sortInsertId, _cellForSort.data);
			var i:int;
			for(i = 0; i < _cellListSize; i ++){
				_cellList[i]._setPosition("center", false);
			}
			_dataListSize = _dataList.length;
			updateDataListId();
			_cellForSort._parent.visible = false;
			_topYV = 0;
			stop();
			//ソートしたのでアップデートイベント
			dispatchEvent(new ListEvent(ListEvent.UPDATE));
		}
		//----------------------------------------------------------//
		//共通
		//----------------------------------------------------------//
		private function start():void
		{
			//trace(_mode);
			_mouseY = stage.mouseY;
			_topYV = 0;
			//mouseDown(null);
		}
		private function stop():void
		{
			_mode = "none";
		}
		
		//セルを入れ替えて最適化
		private function optimizeCells(idV:int):void
		{
			var i:int = 0;
			var cell:_SortableListCell;
			if(idV > 0){
				for(i = 0; i < idV; i ++){
					cell = _cellList.shift();
					_cellList.push(cell);
					if(_mode == "sort"){
						//下へずらす
						cell._setPosition("bottom", false);
					}
				}
			}else if(idV < 0){
				idV = -idV;
				for(i = 0; i < idV; i ++){
					cell = _cellList.pop();
					_cellList.unshift(cell);
					if(_mode == "sort"){
						//下へずらす
						cell._setPosition("center", false);
					}
				}
			}
		}
		//セルのデータidを再適用
		private function updateDataListId():void
		{
			for(var i:int = 0; i < _dataListSize; i ++){
				_dataList[i].id = i;
			}
		}
		//データ数に変化が当たっとき！
		private function changeDataSize():void
		{
			_contentsHeight = _dataListSize * (_realCellHeight) + _cellSpace;
			//スクロールバー更新
			_scrollBar.setContentHeight(_contentsHeight);
			
			//アップデートイベントを出す
			dispatchEvent(new ListEvent(ListEvent.UPDATE));
		}
		
		//セルからのアクション
		internal function _cell_beginSort(dataId:int, cellId:int):void
		{
			beginSort(dataId, cellId);
		}
		internal function _cell_remove(dataId:int, cellId:int):void
		{
			remove(dataId, cellId);
		}
		internal function _cell_message(dataId:int, data:Object = null):void
		{
			messageFromCell(dataId, data);
		}
	}
}