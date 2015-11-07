package com.takumus.ui.list
{
	import flash.display.Sprite;
	
	public class ScrollBar {
		internal var _body:Sprite;
		
		private var _width:Number;
		private var _viewHeight:Number;
		private var _contentHeight:Number;
		
		private var _barHeight:Number;
		
		private var _barMinHeight:Number;
		private var _barMinCompressedHeight:Number;
		
		private var _prevRenderBarHeight:int;
		public function ScrollBar(barWidth:Number, barMinHeight:Number = 100, barMinCompressedHeight:Number = 10)
		{
			_width = barWidth;
			_barMinHeight = barMinHeight;
			_barMinCompressedHeight = barMinCompressedHeight;
			_body = new Sprite();
			//this.addChild(content);
		}
		//表示部分の高さを指定
		public function setViewHeight(value:Number):void
		{
			_viewHeight = value;
			updateBarHeight();
		}
		//中身の高さを指定
		public function setContentHeight(value:Number):void
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
				over = contentY;
			}else if(ratio > 1){
				//下にはみ出たら
				over = _viewHeight - (_contentHeight + contentY);
			}
			
			//バーの最小の高さをセット
			barHeight -= over;
			if(barHeight < _barMinCompressedHeight) barHeight = _barMinCompressedHeight;
			
			//バーを移動
			if(ratio < 0){
				//上にはみ出たら
				_body.y = 0;
			}else if(ratio > 1){
				//下にはみ出たら
				_body.y = (_viewHeight - barHeight);
			}else{
				_body.y = ratio * (_viewHeight - barHeight);
			}
			
			_render(barHeight);
		}
		private function updateBarHeight():void
		{
			_body.visible = _viewHeight <= _contentHeight;
			
			var height:Number = (_viewHeight / _contentHeight) * _viewHeight;
			if(height < _barMinHeight) height = _barMinHeight;
			
			_barHeight = height;
		}
		private function _render(height:Number):void
		{
			//前と同じ大きさだったら再レンダリングしない
			if(_prevRenderBarHeight == int(height)) return;
			_prevRenderBarHeight = height;
			
			render(_width, height);
		}
		protected function render(width:Number, height:Number):void
		{
			_body.graphics.clear();
			_body.graphics.beginFill(0x000000, 0.3);
			_body.graphics.drawRect(0, 0, width, height);
			_body.graphics.endFill();
		}
		
		protected function get body():Sprite
		{
			return _body;
		}
		public function get width():Number
		{
			return _width;
		}
		public function get height():Number
		{
			return _viewHeight;
		}
	}
}