package wing.java.swing;

import java.lang.Thread;
import java.javax.swing.SwingUtilities;

class SwingRunnable implements java.lang.Runnable {
	final runHandler:Void->Void;
	public function new(runHandler:Void->Void) {
		this.runHandler = runHandler;
		SwingUtilities.invokeAndWait(this);
	}

	public function run():Void {
		Thread.setDefaultUncaughtExceptionHandler(new UncaughtExceptionHandler());
		runHandler();
	}
}
