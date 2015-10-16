package
{
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.SortableCell;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class SampleCell extends SortableCell{
		private var _label:TextField;
		private var _dragIcon:DragIcon;
		public function SampleCell(list:List):void
		{
			super(list);
			_label = new TextField();
			_dragIcon = new DragIcon(30);
			
			contents.addChild(_label);
			contents.addChild(_dragIcon);
			
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			//_label.border = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				if(mouseX > cellWidth - 70){
					sortStart();
				}else{
					scrollStart();
				}
			});
		}
		protected override function resize(width:Number, height:Number):void
		{
			contents.graphics.clear();
			contents.graphics.lineStyle(1,0xCCCCCC);
			contents.graphics.beginFill(0xFFFFFF);
			contents.graphics.drawRect(0,0,width, height);
			
			_label.y = (height - _label.height) * 0.5;
			_label.x = 20;
			
			_dragIcon.x = width - 40;
			_dragIcon.y = height * 0.5;
		}
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