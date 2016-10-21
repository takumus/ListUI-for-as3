package
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.ListCell;
	
	import flash.text.TextField;

	public class SampleCell extends ListCell{
		private var _label:TextField;
		private var _buttonA:Button;
		private var _buttonB:Button;
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
			
			//button
			_buttonA = new Button(0xCCCCCC, "button A");
			_buttonB = new Button(0xCCCCCC, "button B");
			//addChild to "body"
			body.addChild(_buttonA);
			body.addChild(_buttonB);
			
			//body clicked
			this.body.addEventListener(ListCellMouseEvent.CLICK, function(e:ListCellMouseEvent):void
			{
				if(e.eventTarget == _buttonA){
					message("A button clicked");
				}else if(e.eventTarget == _buttonB){
					message("B button clicked")
				}else{
					message("body clicked");
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
			
			//label
			_label.y = (height - _label.height) * 0.5;
			_label.x = 10;
			
			//label
			_buttonA.x = width * 0.5 + 5;
			_buttonB.x = width * 0.75 + 5;
			_buttonA.y = 5;
			_buttonB.y = 5;
			_buttonA.resize(width*0.25 - 10, height - 10);
			_buttonB.resize(width*0.25 - 10, height - 10);
		}
		
		//override setData
		protected override function setData(data:CellData):void
		{
			//set data to label
			_label.text = data.data.toString();
		}
	}
}