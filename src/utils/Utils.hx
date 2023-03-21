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
}
