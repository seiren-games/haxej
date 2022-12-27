package wing.java;

import hx.strings.Version;
import java.NativeArray;
import java.lang.System;
import utest.Assert;
import utest.ITest;
import wing.Equal;

using Safety;
using wing.java.NativeArrayTools;

class TestHaxeJ implements ITest {
	public function new() {}

	public function testObject():Void {
		CompileTime.importPackage("wing.java");

		final nativeArray1:NativeArray<Int> = NativeArray.make(0, 1, 2);
		final nativeArray2:NativeArray<Int> = [0, 1, 2].nativeArray();
		Assert.isTrue(Equal.equals(nativeArray1, nativeArray2));

		final javaVersion:String = StringTools.replace(System.getProperty("java.version"), '_', '-');
		trace(Version.of(javaVersion));
		if (Version.of(javaVersion) <= new Version(11)) {
			JavaTools.putEnv("TEST_HAXE_J_ENV", "FOO");
			Assert.isTrue(Sys.getEnv("TEST_HAXE_J_ENV") == "FOO");
		}

		Assert.isTrue(JavaSys.command(['dir ${JavaTools.programPath()}']) == 0);
	}
}
