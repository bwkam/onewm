import haxe.macro.Context;
import haxe.Json;
import sys.io.File;
import utils.Utils;

using haxe.macro.ExprTools;
using Lambda;

@:build(wms.bspwm.macros.Macro.gen_config())
class Main {
	static function main() {
		Utils.return_expr(macro ${build_json()});
		setup();
		inject();
	}

	public static function extra():String {
		return 'echo "hi"';
	}

	public static function inject() {
		File.append("config").writeString(extra() + '\n');
	}

	public static function build_json() {
		var block = [];
		var json = Utils.load("config.json");
		var data = new json2object.JsonParser<Models.JsonModel>().fromJson(Json.stringify(json), "config.json");
		// var config:Map<String, Models.ConfigModel> = data.config;
		// var workspaces:Array<String> = data.workspaces;
		var rules:Array<Map<String, Models.RuleModel>> = data.rules;
		// var exprs_arr = [];

		// build the rules
		for (rule in rules) { // rule is a map
			var expr = macro null;
			for (i in rule) {
				expr = macro Rule.add_rule($v{i});
				block.push(expr);
			}
		}

		// build the config
		// build_config_expr({border_width: "10", top_padding: "5"});

		return macro $b{block};
	}

	macro public static function build_config_expr(expr:haxe.macro.Expr) {
		var types = Context.getModule("wms.bspwm.Bspwm");
		return macro null;
	}
}
