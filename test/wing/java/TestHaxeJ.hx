package wing.java;

import wing.java.swing.MouseCallback;
import java.NativeArray;
import wing.java.swing.ActionCallback;
import wing.java.swing.WindowCallback;
import utest.Assert;
import utest.ITest;
import wing.Equal;

using Safety;

class TestHaxeJ implements ITest {
	public function new() {}

	public function testObject():Void {
		Noop.checkCompilable(ActionCallback);
		Noop.checkCompilable(WindowCallback);
		Noop.checkCompilable(MouseCallback);
		Noop.checkCompilable(JavaTools);

		final nativeArray1:NativeArray<Int> = NativeArray.make(0, 1, 2);
		final nativeArray2:NativeArray<Int> = NativeArrayTools.from([0, 1, 2]);
		Assert.isTrue(Equal.equals(nativeArray1, nativeArray2));

		JavaTools.putEnv("TEST_HAXE_J_ENV", "FOO");
		Assert.isTrue(Sys.getEnv("TEST_HAXE_J_ENV") == "FOO");
	}
}