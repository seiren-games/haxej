package wing.java;

import java.net.URI;
import java.nio.file.Paths;
import wing.java.ToNullable;
import java.lang.Class;
import java.lang.reflect.Field;
import java.util.Map;

class JavaTools {
	// For quick use.
	// It is better to use Apache-Commons-Exec if you want to deal with it in earnest.
	public static function putEnv(env:String, val:String):Void {
		final clazz:Class = Class.forName("java.lang.ProcessEnvironment");
		final field:Field = clazz.getDeclaredField("theCaseInsensitiveEnvironment");
		field.setAccessible(true);

		final envMap:Map<String, String> = (field:FieldNullable).get(null);
		envMap.put(env, val);
	}

	public static inline function programPath():String {
		final uri:URI = java.Lib.toNativeType(Sys).getProtectionDomain().getCodeSource().getLocation().toURI();
		return Paths.get(uri).toString();
	}
}
