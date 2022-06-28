package wing.java.swing;

import java.lang.Runnable;

class RunnableCallback implements Runnable {
	final handler:Void->Void;

	public function new(handler:Void->Void) {
		this.handler = handler;
	}

	public function run():Void {
		handler();
	}
}
