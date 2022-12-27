package wing.java;

import haxe.ds.ReadOnlyArray;
import java.NativeArray;

using Lambda;

class NativeArrayTools {
	// Must be statically typed with `inline` or `@:generic`.
	// Otherwise `ClassCastException` is raised.
	// TODO: rename from2nativeArray;
	public static inline function from<T>(arr:ReadOnlyArray<T>):NativeArray<T> {
		// ref: Lib.nativeArray()
		final ret:NativeArray<T> = new NativeArray(arr.length);
		for (i in 0...arr.length) {
			ret[i] = arr[i];
		}
		return ret;
	}
}
