package com.takumus.ui.list
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class ScrollBar extends Sprite {
		protected var content:Sprite;
		
		private var _width:Number;
		private var _viewHeight:int;
		private var _contentHeight:int;
		
		private var _barHeight:Number;
		public function ScrollBar(barWidth:Number)
		{
			_width = barWidth;
			content = new Sprite();
			this.addChild(content);
		}
		//表示部分の高さを指定
		public function setViewHeight(value:int):void
		{
			_viewHeight = value;
			updateBarHeight();
		}
		//中身の高さを指定
		public function setContentHeight(value:int):void
		{
			_contentHeight = value;
			updateBarHeight();
		}
		//スクロール位置を指定
		public function setContentY(contentY:int):void
		{
			var ratio:Number = (-contentY) / (_contentHeight - _viewHeight);
			var over:Number = 0;
			var barHeight:Number = _barHeight;
			//overを求める
			if(ratio < 0){
				//上にはみ出たら
				over = (-ratio) * _contentHeight;
			}else if(ratio > 1){
				//下にはみ出たら
				over = (ratio - 1) * _contentHeight;
			}
			
			//バーの最小の高さをセット
			barHeight -= over;
			if(barHeight < 10)barHeight = 10;
			
			//バーを移動
			if(ratio < 0){
			}else if(ratio > 1){
				//下にはみ出たら
				content.y = (_viewHeight - barHeight);
			}else{
				content.y = ratio * (_viewHeight - barHeight);
			}
			
			render(_width, barHeight);
		}
		private function updateBarHeight():void
		{
			var height:Number = _viewHeight / _contentHeight;
			if(height < 50){
				height = 50;
			}
			_barHeight = height;
		}
		private function render(width:Number, height:Number):void
		{
			content.graphics.clear();
			content.graphics.beginFill(0xFF0000);
			content.graphics.drawRect(0, 0, width, height);
			content.graphics.endFill();
		}
		
		public override function get width():Number
		{
			return _width;
		}
		public override function get height():Number
		{
			return _viewHeight;
		}
	}
}