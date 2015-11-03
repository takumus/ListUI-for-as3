package
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.ListCell;
	
	import flash.text.TextField;

	public class SampleCell extends ListCell{
		private var _label:TextField;
		private var _dragIcon:DragIcon;
		public function SampleCell(list:List):void
		{
			super(list);
			
			//label
			_label = new TextField();
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			
			//dragIcon for sort
			_dragIcon = new DragIcon(40);
			
			//addChild to "body"
			body.addChild(_label);
			body.addChild(_dragIcon);
			
			
			//mouse down to star drag
			//* do not use "MouseEvent"
			//* use "ListCellMouseEvent"
			body.addEventListener(ListCellMouseEvent.MOUSE_DOWN, function(e:ListCellMouseEvent):void
			{
				//if mouseDown on _dragIcon
				//begin sort from this cell.
				if(e.eventTarget == _dragIcon){
					beginSort();
				}
			});
		}
		
		//override resize
		protected override function resize(width:Number, height:Number):void
		{
			//render cell
			body.graphics.clear();
			body.graphics.lineStyle(1,0xCCCCCC);
			body.graphics.beginFill(0xFFFFFF);
			body.graphics.drawRect(0,0,width, height);
			
			_label.y = (height - _label.height) * 0.5;
			_label.x = 10;
			
			_dragIcon.x = width - _dragIcon.width * 0.5;
			_dragIcon.y = height * 0.5;
		}
		
		//override setData
		protected override function setData(data:CellData):void
		{
			//set data to label
			_label.text = data.data.toString();
		}
	}
}