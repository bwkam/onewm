import haxe.Json;
import sys.io.File;
import utils.Utils;

using haxe.macro.ExprTools;
using Lambda;

@:build(wms.bspwm.macros.Macro.gen_config())
class Main {
	static function main() {
		Utils.build_json();
		setup();
		inject();
	}

	public static function extra():String {
		return 'echo "hi"';
	}

	public static function inject() {
		File.append("config").writeString(extra() + '\n');
	}
}
