package com.takumus.ui.list
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	internal class Cell extends Sprite{
		//セルの大きさ
		private var _cellHeight:Number, _cellWidth:Number;
		
		private var _data:CellData;
		protected var contents:Sprite;
		private var _list:List;
		private var _mode:String;
		internal var cellId:int;
		public function Cell(list:List):void
		{
			this._list = list;
			this.contents = new Sprite();
			this.addChild(contents);
			initCellMouseEvent();
		}
		
		private function initCellMouseEvent():void{
			var pressed:Boolean;
			var mouseMove:Function = function(event:MouseEvent):void{
				if(scrolling){
					pressed = false;
				}
				trace(Math.random());
			};
			var mouseUp:Function = function(event:MouseEvent):void{
				dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_UP));
				if(pressed){
					dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.CLICK));
				}
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			};
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void{
				pressed = !scrolling;//スクロール中ならfalse
				
				dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_DOWN));
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			});
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
		protected final function remove():void
		{
			_list._cell_remove(dataId, cellId);
		}
		protected final function select():void
		{
			_list._cell_select(dataId);
		}
		protected final function get cellHeight():Number
		{
			return _cellHeight;
		}
		protected final function get cellWidth():Number
		{
			return _cellWidth;
		}
		protected final function get scrolling():Boolean
		{
			return _list.scrolling;
		}
		protected function get list():List
		{
			return _list;
		}
		protected function get mode():String
		{
			return _mode;
		}
		protected function setMode(mode:String, def:Boolean):void
		{
			
		}
		
		internal function _dispose():void
		{
			dispose();
		}
		internal function _setData(data:CellData):void
		{
			if(_data && _data.data == data.data) return;
			_data = data;
			setData(data);
		}
		internal function _forceUpdate():void
		{
			setData(data);
		}
		internal function _resize(width:Number, height:Number):void
		{
			_cellWidth = width;
			_cellHeight = height;
			
			resize(width, height);
		}
		internal function get _yForSort():Number
		{
			return this.y + contents.y;
		}
		internal function _setMode(mode:String, def:Boolean):void
		{
			_mode = mode;
			this.setMode(mode, def);
		}
	}
}