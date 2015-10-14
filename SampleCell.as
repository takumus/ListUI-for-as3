package
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.SortableCell;

	public class SampleCell extends SortableCell{
		private var _label:TextField;
		public function SampleCell(list:List):void
		{
			super(list);
			_label = new TextField();
			contents.addChild(_label);
			_label.scaleX = _label.scaleY = 2;
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				if(mouseX < 100){
					scrollStart();
				}else{
					sortStart();
				}
			});
		}
		protected override function setData(data:CellData):void
		{
			_label.text = data.data.toString();
		}
	}
}