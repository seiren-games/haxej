package wing.java;

import java.Lib;
import java.NativeArray;

class NativeArrayTools {
	// Must be statically typed with `inline` or `@:generic`.
	// Otherwise `ClassCastException` is raised.
	// TODO: rename from2nativeArray;
	public static inline function from<T>(array:Array<T>):NativeArray<T> {
		return Lib.nativeArray(array, true);
	}
}
