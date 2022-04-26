package wing.java.swing;

import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

class WindowCallback implements WindowListener {
	final handler:WindowHandler;

	public function new(handler:WindowHandler) {
		this.handler = handler;
	}

	public function windowActivated(event:WindowEvent):Void {
		if (handler.windowActivated != null) {
			handler.windowActivated(event);
		}
	}

	public function windowClosed(event:WindowEvent):Void {
		if (handler.windowClosed != null) {
			handler.windowClosed(event);
		}
	}

	public function windowClosing(event:WindowEvent):Void {
		if (handler.windowClosing != null) {
			handler.windowClosing(event);
		}
	}

	public function windowDeactivated(event:WindowEvent):Void {
		if (handler.windowDeactivated != null) {
			handler.windowDeactivated(event);
		}
	}

	public function windowDeiconified(event:WindowEvent):Void {
		if (handler.windowDeiconified != null) {
			handler.windowDeiconified(event);
		}
	}

	public function windowIconified(event:WindowEvent):Void {
		if (handler.windowIconified != null) {
			handler.windowIconified(event);
		}
	}

	public function windowOpened(event:WindowEvent):Void {
		if (handler.windowOpened != null) {
			handler.windowOpened(event);
		}
	}
}

typedef WindowHandler = {
	final ?windowActivated:WindowEvent->Void;
	final ?windowClosed:WindowEvent->Void;
	final ?windowClosing:WindowEvent->Void;
	final ?windowDeactivated:WindowEvent->Void;
	final ?windowDeiconified:WindowEvent->Void;
	final ?windowIconified:WindowEvent->Void;
	final ?windowOpened:WindowEvent->Void;
}
