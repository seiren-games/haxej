import haxe.io.Path;
import haxe.xml.Printer;
import sys.FileSystem;
import sys.io.File;

using Lambda;
using StringTools;

typedef JavaLib = {
	groupId: String,
	artifactId: String,
	version:String
}

typedef GitInfo = {
	name:String,
	url:String,
	?branch:String,
}

class RunSetup {
	static function main():Void {
		new RunSetup();
	}

	function new() {
		// Clean workTree.
		exec('git clean -ffd -X');

		// Create pom.xml for download dependency jar.
		final root:Xml = Xml.createElement("project");
		root.addChild(createElementWithPCData("modelVersion", "4.0.0"));
		root.addChild(createElementWithPCData("groupId", "haxe"));
		root.addChild(createElementWithPCData("artifactId", "haxe-auto-generated-pom"));
		root.addChild(createElementWithPCData("version", "1.0.0"));

		final dependencies:Xml = Xml.createElement("dependencies");
		root.addChild(dependencies);
		dependencies.addChild(createDependency("org.apache.commons", "commons-exec", "1.3"));

		File.saveContent("pom.xml", "<!--Auto-generated file-->\n" + Printer.print(root, true));

		// Download dependency jar.
		exec('mvn versions:use-latest-releases');
		exec('mvn versions:commit');
		exec('mvn dependency:go-offline');

		// Download haxelib.
		final haxelibs:Array<GitInfo> = [
			{name:"utest", url:'https://github.com/haxe-utest/utest.git'},
			{name:"safety", url:'https://github.com/RealyUniqueName/Safety.git', branch: '1.1.2'},
			{name:"wing", url:'https://github.com/seiren-games/wing.git'},
			{name:"compiletime", url:'https://github.com/jasononeil/compiletime.git'},
			{name:"deep_equal", url:'https://github.com/kevinresol/deep_equal.git'},
			{name:"tink_core", url:'https://github.com/haxetink/tink_core.git', branch: '2.0.2'},
			{name:"hxjava", url:'https://github.com/HaxeFoundation/hxjava.git', branch: '4.2.0'},
			{name:"hxassert", url:'https://github.com/eliasku/hxassert.git'},
		];
		
		haxelibs.iter(haxelib -> {
			exec('git', ['clone', '--depth=1', haxelib.url, '.haxelib/${haxelib.name}']);
			exec('haxelib dev ${haxelib.name} .haxelib/${haxelib.name}');
		});

		// Use custom haxe.
		FileSystem.createDirectory(".haxelib/haxe");
		exec('git', ['clone', '--depth=1', 'https://github.com/seiren-games/haxe.git', '.haxelib/haxe', '--branch', '4.2.5-custom']);

		// Create hxml.
		final hxmlLibs:Array<String> = haxelibs.map(haxelib -> haxelib.name);
		final hxml:Array<String> = ["# Auto-generated file"];
		hxml.push('-main TestAll');
		hxml.push('-debug');
		for (hxmlLib in hxmlLibs) {
			hxml.push('-lib ${hxmlLib}');
		}
		hxml.push('-cp ./test');
		hxml.push('--macro nullSafety("wing", Strict)');
		final hxmlJavaLibs:Array<JavaLib> = getDependencies(File.getContent("pom.xml"));
		for (hxmlJavaLib in hxmlJavaLibs) {
			// As the version may have changed. Load pom.xml again.
			hxml.push(
				'--java-lib %USERPROFILE%/.m2/repository/'
				+ '${hxmlJavaLib.groupId.replace(".", "/")}/'
				+ '${hxmlJavaLib.artifactId}/'
				+ '${hxmlJavaLib.version}/'
				+ '${hxmlJavaLib.artifactId}-${hxmlJavaLib.version}.jar'
			);
		}
		hxml.push('--jvm bin/main.jar');
		hxml.push('--cmd chcp 932 && java -jar bin/main.jar');
		File.saveContent("tests.hxml", hxml.join('\n') + "\n");
		Sys.println("Generated hxml file.");
		Sys.println("Setup Success.");

		// Run tests.
		Sys.putEnv('HAXE_STD_PATH', '.haxelib/haxe/std');
		exec('haxe ./tests.hxml');
		Sys.println("Tests Success.");
	}

	function createElementWithPCData(element:String, pCData:String):Xml {
		final xml:Xml = Xml.createElement(element);
		xml.addChild(Xml.createPCData(pCData));
		return xml;
	}

	function createDependency(groupId:String, artifactId:String, version:Null<String>):Xml {
		final xml:Xml =  Xml.createElement("dependency");
		xml.addChild(createElementWithPCData("groupId", groupId));
		xml.addChild(createElementWithPCData("artifactId", artifactId));
		xml.addChild(createElementWithPCData("version", if (version == null) "0" else version));
		return xml;
	}

	function getDependencies(rawXml:String):Array<JavaLib> {
		final xml:Xml = Xml.parse(rawXml).firstElement();
		return [
			for (element in xml.elementsNamed("dependencies")) {
				for (element in element.elementsNamed("dependency")) {
					{
						groupId: element.elementsNamed("groupId").next().firstChild().nodeValue.trim(),
						artifactId: element.elementsNamed("artifactId").next().firstChild().nodeValue.trim(),
						version: element.elementsNamed("version").next().firstChild().nodeValue.trim()
					}
				}
			}
		];
	}

	function exec(cmd:String, ?maybeArgs:Array<String>):Int {
		final args:Array<String> = if (maybeArgs == null) {
			[];
		} else {
			maybeArgs;
		}
		Sys.println('${Path.removeTrailingSlashes(Sys.getCwd())}> ${cmd} ${args.join(" ")}');
		final exitCode:Int = Sys.command(cmd, maybeArgs);
		if (exitCode != 0) {
			final message:String = 'error occurred. cmd: "${cmd} ${args.join(" ")}"\n'
				+ 'exitCode: ${exitCode}';
			throw message;
		}
		return exitCode;
	}
}
