package utils;

import haxe.macro.Expr;

using Lambda;
using StringTools;

import sys.io.File;
import haxe.macro.Expr.Access;
import haxe.macro.Context;

using haxe.macro.ExprTools;
using StringTools;
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

	public static function build_config_opts() {
		var fields = Context.getBuildFields();
		var types = Context.getModule('Config');
		for (t in types) {
			switch (t) {
				case TEnum(t, _):
					// build the props and their gets/sets
					for (f in t.get().names) {
						fields.push({
							name: f,
							kind: FProp("default", "set", macro :String),
							pos: Context.currentPos(),
							access: [Access.APublic, Access.AStatic],
						});

						fields.push({
							name: 'set_$f',
							kind: FFun({
								args: [{name: "x"}],
								ret: macro :String,
								expr: macro {
									return $i{f} = "bspc config " + $v{f} + " " + x;
								},
							}),
							access: [Access.APublic, Access.AStatic],
							pos: Context.currentPos()
						});
					}
				case _:
			}
		}
		return fields;
	}

	public static function append_config_opts() {
		var fields = Context.getBuildFields();
		var exprs = [];
		for (f in fields) {
			switch (f.kind) {
				case FFun(f):
					// File.write("config", false);
					exprs.push(macro var file_cnt:String = "");
					f.expr.iter((e) -> if (e.toString().startsWith("Config")) exprs.push(macro file_cnt = file_cnt + $e + '\n'));
					exprs.push(macro sys.io.File.append("config", false).writeString(file_cnt));
				case _:
			}
		}
		fields.push({
			name: "setup",
			kind: FFun({
				args: [],
				expr: macro $b{exprs},
			}),
			access: [Access.APublic, Access.AStatic],
			pos: Context.currentPos(),
		});
		return fields;
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
