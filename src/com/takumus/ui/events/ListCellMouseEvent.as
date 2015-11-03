package com.takumus.ui.events {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public final class ListCellMouseEvent extends Event {
		public static const MOUSE_DOWN:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_DOWN";
		public static const MOUSE_DOWN_OTHER:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_DOWN_OTHER";
		public static const MOUSE_UP:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_UP";
		public static const MOUSE_UP_OTHER:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_UP_OTHER";
		
		public static const CLICK:String = "com.takumus.ui.events.ListCellMouseEvent.CLICK";
		private var _parentEvent:MouseEvent;
		public function ListCellMouseEvent(type : String, parentEvent:MouseEvent) {
			super(type, false, false);
			_parentEvent = parentEvent;
		}
		public function get eventTarget():Object
		{
			return _parentEvent?_parentEvent.target:null;
		}
	}
}
