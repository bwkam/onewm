package wms.bspwm.macros;

import sys.FileSystem;
import sys.io.File;
import haxe.macro.Expr.Access;
import haxe.macro.Context;

using haxe.macro.ExprTools;
using StringTools;
using Lambda;

class Macro {
	public static function build_config() {
		var fields = Context.getBuildFields();
		var types = Context.getModule("wms.bspwm.Bspwm");
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

	public static function gen_config() {
		var fields = Context.getBuildFields();
		var exprs = [];
		for (f in fields) {
			switch (f.kind) {
				case FFun(f):
					File.write("config", false);
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
}
