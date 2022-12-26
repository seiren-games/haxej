package wing.java;

import hx.strings.Version;
import java.NativeArray;
import java.lang.System;
import utest.Assert;
import utest.ITest;
import wing.Equal;

using Safety;

class TestHaxeJ implements ITest {
	public function new() {}

	public function testObject():Void {
		CompileTime.importPackage("wing.java");

		final nativeArray1:NativeArray<Int> = NativeArray.make(0, 1, 2);
		final nativeArray2:NativeArray<Int> = NativeArrayTools.from([0, 1, 2]);
		Assert.isTrue(Equal.equals(nativeArray1, nativeArray2));

		final javaVersion:String = StringTools.replace(System.getProperty("java.version"), '_', '-');
		final javaVersionMajor:Int = Version.of(javaVersion).major;
		if (javaVersionMajor <= 11) {
			JavaTools.putEnv("TEST_HAXE_J_ENV", "FOO");
			Assert.isTrue(Sys.getEnv("TEST_HAXE_J_ENV") == "FOO");
		}

		Assert.isTrue(JavaSys.command(['dir ${JavaTools.programPath()}']) == 0);
	}
}
