package wing.java.swing;

import java.javax.swing.event.TreeSelectionEvent;
import java.javax.swing.event.TreeSelectionListener;

class TreeSelectionCallback implements TreeSelectionListener {
	final handler:TreeSelectionEvent->Void;
	public function new(handler:TreeSelectionEvent->Void) {
		this.handler = handler;
	}
	public function valueChanged(event:TreeSelectionEvent):Void {
		handler(event);
	}
}
