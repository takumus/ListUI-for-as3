package com.takumus.ui.events {
	import flash.events.Event;

	/**
	 * @author takumus
	 */
	public class ListCellMouseEvent extends Event {
		public static const MOUSE_DOWN:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_DOWN";
		public static const MOUSE_DOWN_OTHER:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_DOWN_OTHER";
		public static const MOUSE_UP:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_UP";
		public static const MOUSE_UP_OTHER:String = "com.takumus.ui.events.ListCellMouseEvent.MOUSE_UP_OTHER";
		
		public static const CLICK:String = "com.takumus.ui.events.ListCellMouseEvent.CLICK";
		public function ListCellMouseEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
