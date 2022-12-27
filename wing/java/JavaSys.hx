package wing.java;

import haxe.ds.ReadOnlyArray;
import java.NativeArray;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import wing.SysCommandLine;

using Safety;
using wing.java.NativeArrayTools;

class JavaSys {
	/**
	 * Prevent garbled output.  
	 * - `Sys.command` causes garbled output.
	 */
	public static function command(cmds:ReadOnlyArray<String>, ?maybeExitValues:ReadOnlyArray<Int>):Int {
		final cmdLine:SysCommandLine = new SysCommandLine(cmds);
		final commandLine:CommandLine = if (cmdLine.args == null) {
			final comspec:String = Sys.getEnv("COMSPEC").or("cmd.exe");
			new CommandLine(comspec).addArguments(NativeArray.make("/C", cmdLine.cmd));
		} else {
			new CommandLine(cmdLine.cmd).addArguments(cmdLine.args.nativeArray());
		}
		final exitValues:ReadOnlyArray<Int> = maybeExitValues.or([0]);
		final executor:DefaultExecutor = new DefaultExecutor();
		executor.setExitValues(exitValues.nativeArray());
		return executor.execute(commandLine);
	}
}
