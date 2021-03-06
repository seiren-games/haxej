import haxe.io.Path;
import haxe.xml.Printer;
import sys.io.File;

using StringTools;

typedef JavaLib = {
	groupId: String,
	artifactId: String,
	version:String
}

class RunSetup {
	static function main():Void {
		new RunSetup();
	}

	function new() {
		final root:Xml = Xml.createElement("project");
		root.addChild(createElementWithPCData("modelVersion", "4.0.0"));
		root.addChild(createElementWithPCData("groupId", "haxe"));
		root.addChild(createElementWithPCData("artifactId", "haxe-auto-generated-pom"));
		root.addChild(createElementWithPCData("version", "1.0.0"));

		final dependencies:Xml = Xml.createElement("dependencies");
		root.addChild(dependencies);
		dependencies.addChild(createDependency("org.apache.commons", "commons-exec", "1.3"));

		File.saveContent("pom.xml", "<!--Auto-generated file-->\n" + Printer.print(root, true));

		exec('mvn versions:use-latest-releases');
		exec('mvn versions:commit');
		exec('mvn dependency:go-offline');

		final haxelibCommands:Array<String> = [
			"haxelib git utest https://github.com/haxe-utest/utest.git --quiet",
			"haxelib install safety --quiet",
			"haxelib git wing https://github.com/seiren-games/wing.git --quiet",
			"haxelib install compiletime --quiet",
			"haxelib git deep_equal https://github.com/kevinresol/deep_equal.git --quiet",
			"haxelib install tink_core --quiet",
			"haxelib install hxjava --quiet",
		];
		for (haxelibCommand in haxelibCommands) {
			exec(haxelibCommand);
		}

		final hxmlLibs:Array<String> = [
			for (haxelibCommand in haxelibCommands) {
				haxelibCommand.split(" ")[2];
			}
		];

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
