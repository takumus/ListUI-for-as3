package com.takumus.ui.list
{
	import com.takumus.ui.events.ListCellMouseEvent;
	
	import flash.display.Sprite;

	internal class _ListCell{
		//セルの大きさ
		private var _cellHeight:Number, _cellWidth:Number;
		
		private var _data:CellData;
		internal var _parent:Sprite;
		protected var body:Sprite;
		private var _list:List;
		private var _mode:String;
		internal var cellId:int;
		public function _ListCell(list:List):void
		{
			this._list = list;
			_parent = new Sprite();
			this.body = new Sprite();
			_parent.addChild(body);
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
		protected final function remove():void
		{
			_list._cell_remove(dataId, cellId);
		}
		[Deprecated(deprecatedReplacement="message")]
		protected final function select(args:Object = null):void
		{
			_list._cell_message(dataId, args);
		}
		protected final function message(data:Object):void
		{
			_list._cell_message(dataId, data);
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
		internal function _mouse_down_other():void
		{
			body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_DOWN_OTHER, null));
		}
		internal function _mouse_up_other():void
		{
			body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_UP_OTHER, null));
		}
		internal function _dispose():void
		{
			dispose();
		}
		internal function _setData(data:CellData, force:Boolean = false):void
		{
			if(!force){
				if(_data == data){
					return;
				}
			}
			_data = data;
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