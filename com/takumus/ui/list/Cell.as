package com.takumus.ui.list
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	internal class Cell{
		//セルの大きさ
		private var _cellHeight:Number, _cellWidth:Number;
		
		private var _data:CellData;
		internal var _parent:Sprite;
		protected var body:Sprite;
		private var _list:List;
		private var _mode:String;
		internal var cellId:int;
		public function Cell(list:List):void
		{
			this._list = list;
			_parent = new Sprite();
			this.body = new Sprite();
			_parent.addChild(body);
			initCellMouseEvent();
		}
		
		private function initCellMouseEvent():void{
			var pressed:Boolean;
			var startX:Number;
			var startY:Number;
			var mouseMove:Function = function(event:MouseEvent):void{
				if( Math.abs(startX - body.stage.mouseX) > 10||
					Math.abs(startY - body.stage.mouseY) > 10){
					pressed = false;
				}
			};
			var mouseUp:Function = function(event:MouseEvent):void{
				body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_UP));
				if(pressed){
					body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.CLICK));
				}
				body.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				body.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			};
			
			body.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void{
				pressed = !scrolling;//スクロール中ならfalse
				startX = body.stage.mouseX;
				startY = body.stage.mouseY;
				body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_DOWN));
				body.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
				body.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
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
		internal function _setMode(mode:String, def:Boolean):void
		{
			_mode = mode;
			this.setMode(mode, def);
		}
	}
}