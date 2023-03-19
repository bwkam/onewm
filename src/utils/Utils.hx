package utils;

import haxe.Json;
import haxe.macro.Expr;

using Lambda;

class Utils {
	macro public static function load(path:String) {
		return try {
			var json = haxe.Json.parse(sys.io.File.getContent(path));
			macro $v{json};
		} catch (e) {
			haxe.macro.Context.error('Failed to load json: $e', haxe.macro.Context.currentPos());
		}
	}
	// macro public static function return_expr(?expr:haxe.macro.Expr) {
	// 	return build_json();
	// }
	// public static function build_json() {
	// 	var block = [];
	// 	var json = Utils.load("config.json");
	// 	var data = new json2object.JsonParser<Models.JsonModel>().fromJson(Json.stringify(json), "config.json");
	// 	// var config:Map<String, Models.ConfigModel> = data.config;
	// 	// var workspaces:Array<String> = data.workspaces;
	// 	var rules:Array<Map<String, Models.RuleModel>> = data.rules;
	// 	// var exprs_arr = [];
	// 	// build the rules
	// 	for (rule in rules) { // rule is a map
	// 		var expr = macro null;
	// 		for (i in rule) {
	// 			expr = macro Rule.add_rule($v{i});
	// 			block.push(expr);
	// 		}
	// 	}
	// 	// build the config
	// 	// build_config_expr({border_width: "10", top_padding: "5"});
	// 	return macro $b{block};
	// }
}
