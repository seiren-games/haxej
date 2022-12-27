package wing.java;

import hx.strings.Version;
import java.lang.Class;
import java.lang.System;
import java.lang.reflect.Field;
import java.net.URI;
import java.nio.file.Paths;
import java.util.Map;
import wing.java.ToNullable;

class JavaTools {
	// For quick use.
	// It is better to use Apache-Commons-Exec if you want to deal with it in earnest.
	public static function putEnv(env:String, val:String):Void {
		final javaVersion:String = StringTools.replace(System.getProperty("java.version"), '_', '-');
		if (Version.of(javaVersion) > new Version(11)) {
			throw 'Only available in version 11 or lower. Now javaVersion:${javaVersion}';
		}

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
