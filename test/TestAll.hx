import wing.java.TestHaxeJ;
import utest.Runner;
import utest.ui.Report;

class TestAll {
	public static function main():Void {
		var runner = new Runner();
		runner.addCase(new TestHaxeJ());
		Report.create(runner);
		runner.run();
	}
}
