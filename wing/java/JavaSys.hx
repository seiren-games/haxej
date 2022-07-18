package wing.java;

import java.NativeArray;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;

using Safety;

class JavaSys {
	/**
	 * Prevent garbled output.  
	 * - `Sys.command` causes garbled output.
	 */
	public static function command(cmd:String, ?args:Array<String>):Int {
		final commandLine:CommandLine =
			if (args == null) {
				final comspec:String = Sys.getEnv("COMSPEC").or("cmd.exe");
				new CommandLine(comspec)
				.addArguments(NativeArray.make("/C", cmd));
			}
			else {
				new CommandLine(cmd)
				.addArguments(NativeArrayTools.from(args));
			}
		final executor:DefaultExecutor = new DefaultExecutor();
		return executor.execute(commandLine);
	}
}
