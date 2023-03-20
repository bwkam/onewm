import sys.io.File;
import haxe.macro.Context;

using StringTools;
using haxe.macro.ExprTools;

class Rule {
	macro public static function add_rule(name:haxe.macro.Expr) {
		var rule = "bspc rule -a";
		switch name.expr {
			case EObjectDecl(fields):
				if (Context.unify(Context.typeof(name), Context.getType('Config.TRule'))) {
					var fld_names = fields.map(e -> e.field);
					var cnt = 0;
					for (f in fields) {
						rule = '$rule ${fld_names[cnt]}=${f.expr.toString()}';
						cnt++;
					}

					rule = rule + '\n';
				}
			default:
				haxe.macro.Context.error('Invalid expression', name.pos);
		}

		File.append("config", false).writeString(rule);

		return macro null;
	}
}
