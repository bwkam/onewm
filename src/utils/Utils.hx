package utils;

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

	macro public static function return_expr(expr:haxe.macro.Expr) {
		return macro $expr;
	}
}
