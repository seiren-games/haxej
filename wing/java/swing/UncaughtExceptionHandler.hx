package wing.java.swing;

import java.lang.System;
import java.lang.Throwable;
import java.lang.Thread;

class UncaughtExceptionHandler implements Thread_UncaughtExceptionHandler {
	public function new() {}

	public function uncaughtException(thread:Thread, throwable:Throwable):Void {
		System.err.print('Exception in thread "${thread.getName()}" ');
		throwable.printStackTrace();
		Sys.exit(1);
	}
}
