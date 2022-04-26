package wing.java.swing;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Easier to assign event processing for multiple buttons to individual functions.
 */
class ActionCallback implements ActionListener {
	final handler:ActionEvent->Void;

	public function new(handler:ActionEvent->Void) {
		this.handler = handler;
	}

	public function actionPerformed(event:ActionEvent):Void {
		handler(event);
	}
}
