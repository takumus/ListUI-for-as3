package com.takumus.ui.events {
	import com.takumus.ui.list.CellData;
	
	import flash.events.Event;

	/**
	 * @author takumus
	 */
	public final class ListEvent extends Event {
		[Deprecated(deprecatedReplacement="MESSAGE")]
		public static const SELECT:String = "com.takumus.ui.events.ListEvent.MESSAGE";
		public static const MESSAGE:String = "com.takumus.ui.events.ListEvent.MESSAGE";
		public static const UPDATE:String = "com.takumus.ui.events.ListEvent.UPDATE";
		public static const REMOVE:String = "com.takumus.ui.events.ListEvent.REMOVE";
		public var cellData:CellData;
		public var data:Object;
		public var message:Object;
		public function ListEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}
