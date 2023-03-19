import haxe.macro.Context;
import haxe.Json;
import sys.io.File;
import utils.Utils;
import wms.bspwm.Bspwm;

using haxe.macro.ExprTools;
using Lambda;

@:build(wms.bspwm.macros.Macro.gen_config())
class Main {
	static function main() {
		Config.border_width = "10";
		Config.top_padding = "3";

		Rule.add_rule({app: "Gimp", state: "floating"});
		Rule.add_rule({app: "Gimp2", state: "tiling"});

		Workspaces.name(["1", "2", "3"]);

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
