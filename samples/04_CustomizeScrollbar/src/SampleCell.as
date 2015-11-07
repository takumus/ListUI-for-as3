package
{
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.ListCell;
	
	import flash.text.TextField;

	public class SampleCell extends ListCell{
		private var _label:TextField;
		public function SampleCell(list:List):void
		{
			super(list);
			
			//label
			_label = new TextField();
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			
			//addChild to "body"
			body.addChild(_label);
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
		}
		
		//override setData
		protected override function setData(data:CellData):void
		{
			//set data to label
			_label.text = data.data.toString();
		}
	}
}