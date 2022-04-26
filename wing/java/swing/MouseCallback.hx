package wing.java.swing;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

class MouseCallback implements MouseListener {
	final handler:MouseHandler;

	public function new(handler:MouseHandler) {
		this.handler = handler;
	}

	public function mouseClicked(event:MouseEvent) {
		if (handler.mouseClicked != null) {
			handler.mouseClicked(event);
		}
	}

	public function mouseEntered(event:MouseEvent) {
		if (handler.mouseEntered != null) {
			handler.mouseEntered(event);
		}
	}

	public function mouseExited(event:MouseEvent) {
		if (handler.mouseExited != null) {
			handler.mouseExited(event);
		}
	}

	public function mousePressed(event:MouseEvent) {
		if (handler.mousePressed != null) {
			handler.mousePressed(event);
		}
	}

	public function mouseReleased(event:MouseEvent) {
		if (handler.mouseReleased != null) {
			handler.mouseReleased(event);
		}
	}
}

typedef MouseHandler = {
	final ?mouseClicked:MouseEvent->Void;
	final ?mouseEntered:MouseEvent->Void;
	final ?mouseExited:MouseEvent->Void;
	final ?mousePressed:MouseEvent->Void;
	final ?mouseReleased:MouseEvent->Void;
}
