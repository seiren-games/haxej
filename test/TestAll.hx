import utest.Runner;
import utest.ui.Report;
import wing.java.TestHaxeJ;

class TestAll {
	public static function main():Void {
		Sys.println('env:HAXE_STD_PATH=${Sys.getEnv('HAXE_STD_PATH')}');

		final runner:Runner = new Runner();
		runner.addCase(new TestHaxeJ());
		Report.create(runner);
		runner.run();
	}
}
