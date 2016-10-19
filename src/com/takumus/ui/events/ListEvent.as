package com.takumus.ui.events {
	import com.takumus.ui.list.CellData;
	
	import flash.events.Event;

	/**
	 * @author takumus
	 */
	public final class ListEvent extends Event {
		public static const SELECT:String = "com.takumus.ui.events.ListEvent.SELECT";
		public static const UPDATE:String = "com.takumus.ui.events.ListEvent.UPDATE";
		public static const REMOVE:String = "com.takumus.ui.events.ListEvent.REMOVE";
		public var cellData:CellData;
		public var args:Object;
		public function ListEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}
