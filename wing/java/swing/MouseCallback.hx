package wing.java.swing;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

class MouseCallback implements MouseListener {
	final handler:MouseHandler;

	public function new(handler:MouseHandler) {
		this.handler = handler;
	}

	public function mouseClicked(event:MouseEvent):Void {
		if (handler.mouseClicked != null) {
			handler.mouseClicked(event);
		}
	}

	public function mouseEntered(event:MouseEvent):Void {
		if (handler.mouseEntered != null) {
			handler.mouseEntered(event);
		}
	}

	public function mouseExited(event:MouseEvent):Void {
		if (handler.mouseExited != null) {
			handler.mouseExited(event);
		}
	}

	public function mousePressed(event:MouseEvent):Void {
		if (handler.mousePressed != null) {
			handler.mousePressed(event);
		}
	}

	public function mouseReleased(event:MouseEvent):Void {
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
