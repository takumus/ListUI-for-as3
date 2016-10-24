package
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.ListCell;
	
	import flash.text.TextField;

	public class SimpleCell extends ListCell{
		private var _label:TextField;
		private var _dragIcon:DragIcon;
		private var _removeIcon:RemoveIcon;
		public function SimpleCell(list:List):void
		{
			super(list);
			
			//label
			_label = new TextField();
			
			//icons
			_dragIcon = new DragIcon(20);
			_removeIcon = new RemoveIcon(10);
			
			body.addChild(_label);
			body.addChild(_dragIcon);
			body.addChild(_removeIcon);
			
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			
			//mousedown
			body.addEventListener(ListCellMouseEvent.MOUSE_DOWN, function(e:ListCellMouseEvent):void
			{
				
				if(body.mouseX > cellWidth - 70){
					//if mousedown on right of cell, begin sort.
					beginSort();
				}
				
				//another example
				/*
				if(e.eventTarget == _dragIcon){
					beginSort();
				}
				*/
			});
			
			//click
			body.addEventListener(ListCellMouseEvent.CLICK, function(e:ListCellMouseEvent):void
			{
				if(body.mouseX < 70){
					//if click on left of cell, remove this cell.
					remove();
				}else if(body.mouseX < cellWidth - 70){
					//if click on center of cell, message.
					message("Hi. My data is [" + data.data + "]");
				}
			});
		}
		//resize
		protected override function resize(width:Number, height:Number):void
		{
			//rerender on resize.
			body.graphics.clear();
			body.graphics.lineStyle(1,0xCCCCCC);
			body.graphics.beginFill(0xFFFFFF);
			body.graphics.drawRect(0,0,width, height);
			
			//update positions
			_label.y = (height - _label.height) * 0.5;
			_label.x = 60;
			
			_dragIcon.x = width - 40;
			_dragIcon.y = height * 0.5;
			
			_removeIcon.x = 30;
			_removeIcon.y = height * 0.5;
		}
		//on set data
		protected override function setData(data:CellData):void
		{
			_label.text = data.data.toString();
		}
	}
}

import flash.display.Shape;
class DragIcon extends Shape{
	public function DragIcon(size:Number):void
	{
		this.graphics.lineStyle(3, 0xCCCCCC);
		this.graphics.moveTo(-size * 0.5, - size * 0.5);
		this.graphics.lineTo(size * 0.5, - size * 0.5);
		
		this.graphics.moveTo(-size * 0.5, 0);
		this.graphics.lineTo(size * 0.5, 0);
		
		this.graphics.moveTo(-size * 0.5, size * 0.5);
		this.graphics.lineTo(size * 0.5, size * 0.5);
	}
}

class RemoveIcon extends Shape{
	public function RemoveIcon(size:Number):void
	{
		this.graphics.lineStyle(3, 0xCCCCCC);
		
		this.graphics.moveTo(-size * 0.5, -size * 0.5);
		this.graphics.lineTo(size * 0.5, size * 0.5);
		
		this.graphics.moveTo(size * 0.5, -size * 0.5);
		this.graphics.lineTo(-size * 0.5, size * 0.5);
	}
}