package wing.java;

import haxe.ds.ReadOnlyArray;
import java.NativeArray;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;

using Safety;

class JavaSys {
	/**
	 * Prevent garbled output.  
	 * - `Sys.command` causes garbled output.
	 */
	public static function command(cmd:String, ?args:ReadOnlyArray<String>, ?maybeExitValues:ReadOnlyArray<Int>):Int {
		final commandLine:CommandLine = if (args == null) {
			final comspec:String = Sys.getEnv("COMSPEC").or("cmd.exe");
			new CommandLine(comspec).addArguments(NativeArray.make("/C", cmd));
		} else {
			new CommandLine(cmd).addArguments(NativeArrayTools.from(args));
		}
		final exitValues:ReadOnlyArray<Int> = maybeExitValues.or([0]);
		final executor:DefaultExecutor = new DefaultExecutor();
		executor.setExitValues(NativeArrayTools.from(exitValues));
		return executor.execute(commandLine);
	}
}
