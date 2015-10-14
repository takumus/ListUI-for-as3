package
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import list.CellData;
	import list.List;
	import list.SortableCell;

	public class MyCell extends SortableCell{
		private var _label:TextField;
		public function MyCell(list:List):void
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