import utest.Runner;
import utest.ui.Report;
import wing.java.TestHaxeJ;

class TestAll {
	public static function main():Void {
		Sys.putEnv('HAXE_STD_PATH', '.haxelib/haxe/std');
		final runner:Runner = new Runner();
		runner.addCase(new TestHaxeJ());
		Report.create(runner);
		runner.run();
	}
}
