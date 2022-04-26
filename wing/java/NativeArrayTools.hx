package wing.java;

import java.NativeArray;
import haxe.ds.ReadOnlyArray;

class NativeArrayTools {
	// Must be statically typed with `inline` or `@:generic`.
	// Otherwise `ClassCastException` is raised.
	@:generic
	public static function from<T>(array:ReadOnlyArray<T>):NativeArray<T> {
		final nativeArray:NativeArray<T> = new NativeArray(array.length);
		for (i in 0...nativeArray.length) {
			nativeArray[i] = array[i];
		}
		return nativeArray;
	}
}
