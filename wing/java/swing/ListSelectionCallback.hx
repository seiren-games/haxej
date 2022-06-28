package wing.java.swing;

import java.javax.swing.event.ListSelectionEvent;
import java.javax.swing.event.ListSelectionListener;

class ListSelectionCallback implements ListSelectionListener {
	final handler:ListSelectionEvent->Void;
	public function new(handler:ListSelectionEvent->Void) {
		this.handler = handler;
	}

	public function valueChanged(event:ListSelectionEvent):Void {
		handler(event);
	}
}
