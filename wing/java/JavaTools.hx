package wing.java;

import java.lang.Class;
import java.lang.reflect.Field;
import java.net.URI;
import java.nio.file.Paths;
import java.util.Map;
import wing.java.ToNullable;

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

	// https://github.com/HaxeFoundation/haxe/pull/10697 
	// - It will be replaced by std after release.
	public static inline function programPath():String {
		final uri:URI = java.Lib.toNativeType(Sys).getProtectionDomain().getCodeSource().getLocation().toURI();
		return Std.string(Paths.get(uri));
	}
}
