package com.takumus.ui.events {
	import com.takumus.ui.list.CellData;
	import flash.events.Event;

	/**
	 * @author takumus
	 */
	public class ListEvent extends Event {
		public static const SELECT:String = "com.takumus.ui.events.ListEvent.SELECT";
		public static const UPDATE:String = "com.takumus.ui.events.ListEvent.UPDATE";
		private var _data:CellData;
		public function ListEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
