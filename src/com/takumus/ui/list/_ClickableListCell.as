package com.takumus.ui.list
{
	import com.takumus.ui.events.ListCellMouseEvent;
	
	import flash.events.MouseEvent;
	
	public class _ClickableListCell extends _ListCell
	{
		private var _pressed:Boolean;
		private var _startX:Number;
		private var _startY:Number;
		public function _ClickableListCell(list:List)
		{
			super(list);
			this.body.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		private function mouseMove(event:MouseEvent):void
		{
			if( Math.abs(_startX - body.stage.mouseX) > 10||
				Math.abs(_startY - body.stage.mouseY) > 10){
				_pressed = false;
				mouseUp(null);
			}
		}
		private function mouseUp(event:MouseEvent):void
		{
			body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_UP, event));
			if(_pressed){
				body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.CLICK, event));
			}
			body.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			body.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			var cellList:Vector.<_SortableListCell> = list.getCell();
			//trace(cellId);
			for(var i:int = 0; i < cellList.length; i ++){
				if(cellList[i].cellId != cellId) cellList[i]._mouse_up_other();
				//trace(":"+cellList[i].cellId);
			}
		}
		private function mouseDown(event:MouseEvent):void
		{
			if(scrolling) return;
			_pressed = true;
			_startX = body.stage.mouseX;
			_startY = body.stage.mouseY;
			body.dispatchEvent(new ListCellMouseEvent(ListCellMouseEvent.MOUSE_DOWN, event));
			body.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			body.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			var cellList:Vector.<_SortableListCell> = list.getCell();
			for(var i:int = 0; i < cellList.length; i ++){
				if(cellList[i].cellId != cellId) cellList[i]._mouse_down_other();
			}
		}
		override internal function _dispose():void
		{
			this.body.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			super._dispose();
		}
	}
}