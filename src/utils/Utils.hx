package utils;

import haxe.macro.Context;
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

	macro public static function build_json() {
		var block = [];
		var json = Utils.load("config.json");
		var data = new json2object.JsonParser<Models.JsonModel>().fromJson(Json.stringify(json), "config.json");
		var config:Map<String, Models.ConfigModel> = data.config;
		var workspaces:Array<String> = data.workspaces;
		var rules:Array<Map<String, Models.RuleModel>> = data.rules;

		return macro $b{block};
	}
}
