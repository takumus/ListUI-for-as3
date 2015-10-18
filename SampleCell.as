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
		private var _removeIcon:RemoveIcon;
		public function SampleCell(list:List):void
		{
			super(list);
			
			//ラベルアイコン
			_label = new TextField();
			
			//ドラッグアイコン
			_dragIcon = new DragIcon(20);
			//削除アイコン
			_removeIcon = new RemoveIcon(10);
			
			contents.addChild(_label);
			contents.addChild(_dragIcon);
			contents.addChild(_removeIcon);
			
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			
			//マウスダウンで、ソートかスクロール開始。
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				if(mouseX > cellWidth - 70){
					//ドラッグアイコンらへんだったら、ソート開始
					sortStart();
				}else if(mouseX < 70){
					//削除アイコンらへんだったら削除
					remove();
				}else{;
					//それ以外だったらただのスクロール
					scrollStart();
				}
			});
		}
		protected override function resize(width:Number, height:Number):void
		{
			//セルのサイズ変更時の処理
			contents.graphics.clear();
			contents.graphics.lineStyle(1,0xCCCCCC);
			contents.graphics.beginFill(0xFFFFFF);
			contents.graphics.drawRect(0,0,width, height);
			
			_label.y = (height - _label.height) * 0.5;
			_label.x = 60;
			
			_dragIcon.x = width - 40;
			_dragIcon.y = height * 0.5;
			
			_removeIcon.x = 30;
			_removeIcon.y = height * 0.5;
		}
		protected override function setData(data:CellData):void
		{
			//セルにデータが入ったときの処理
			//data.dataは、setDataで指定したデータ。
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