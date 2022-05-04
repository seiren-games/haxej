package wing.java;

import java.NativeArray;
import java.Lib;

class NativeArrayTools {
	// Must be statically typed with `inline` or `@:generic`.
	// Otherwise `ClassCastException` is raised.
	public static inline function from<T>(array:Array<T>):NativeArray<T> {
		return Lib.nativeArray(array, true);
	}
}
