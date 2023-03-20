import haxe.macro.Context;
import sys.io.File;

using haxe.macro.ExprTools;
using Lambda;

@:build(utils.Utils.append_config_opts())
class Main {
	static function main() {
		// Config.border_width = "10";
		// Config.top_padding = "3";

		Rule.add_rule({app: "Gimp", state: "floating"});
		Rule.add_rule({app: "Gimp2", state: "tiling"});

		// Workspaces.name(["1", "2", "3"]);

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
