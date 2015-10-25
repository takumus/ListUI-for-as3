package
{
	import com.takumus.ui.events.ListCellMouseEvent;
	import com.takumus.ui.list.CellData;
	import com.takumus.ui.list.List;
	import com.takumus.ui.list.SortableCell;
	
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
			
			body.addChild(_label);
			body.addChild(_dragIcon);
			body.addChild(_removeIcon);
			
			_label.mouseEnabled = false;
			_label.autoSize = "left";
			_label.text = "A";
			
			//マウスダウン
			body.addEventListener(ListCellMouseEvent.MOUSE_DOWN, function(e:ListCellMouseEvent):void
			{
				if(mode == "default"){
					//通常モードだったら
					//何もない
					
				}else if(mode == "edit"){
					//編集モードだったら
					
					if(body.mouseX > cellWidth - 70){
						//ドラッグアイコンらへんだったら、ソート開始
						sortStart();
					}
				}
			});
			//マウスクリック
			body.addEventListener(ListCellMouseEvent.CLICK, function(e:ListCellMouseEvent):void
			{
				if(body.mouseX < 70){
					//削除アイコンらへんだったら、削除
					remove();
				}else if(body.mouseX < cellWidth - 70){
					//アイコンにかぶってなかったら、ただのクリック(select)
					select();
				}
			});
		}
		//リサイズ時
		protected override function resize(width:Number, height:Number):void
		{
			//セルのサイズ変更時の処理
			body.graphics.clear();
			body.graphics.lineStyle(1,0xCCCCCC);
			body.graphics.beginFill(0xFFFFFF);
			body.graphics.drawRect(0,0,width, height);
			
			_label.y = (height - _label.height) * 0.5;
			_label.x = 60;
			
			_dragIcon.x = width - 40;
			_dragIcon.y = height * 0.5;
			
			_removeIcon.x = 30;
			_removeIcon.y = height * 0.5;
		}
		//モード変更時
		protected override function setMode(mode:String, def:Boolean):void
		{
			if(mode == "default"){
				_dragIcon.visible = _removeIcon.visible = false;
			}else{
				_dragIcon.visible = _removeIcon.visible = true;
			}
		}
		//データセット時
		protected override function setData(data:CellData):void
		{
			//セルにデータが入ったときの処理
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