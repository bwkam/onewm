package wms.bspwm;

import sys.io.File;
import haxe.macro.Context;

using StringTools;
using haxe.macro.ExprTools;

class Bspwm {}

@:build(wms.bspwm.macros.Macro.build_config())
class Config {}

class Monitor {}

class Rule {
	macro public static function add_rule(name:haxe.macro.Expr) {
		var rule = "bspc rule -a";
		switch name.expr {
			case EObjectDecl(fields):
				if (Context.unify(Context.typeof(name), Context.getType('TRule'))) {
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

class Workspaces {
	public static function name(names:Array<String>) {
		var file = File.append("config", false);
		var str = "bspc monitor -d ";
		for (n in names) {
			str = str + n + " ";
		}
		str = str + '\n';
		file.writeString(str);
		file.close();
	}
}

enum EConfig {
	border_width;
	window_gap;
	active_border_color;
	focus_follows_pointer;
	focused_border_color;
	left_padding;
	left_monocle_padding;
	right_padding;
	right_monocle_padding;
	top_padding;
	top_monocle_padding;
	pointer_follows_focus;
	pointer_follows_monitor;
	click_to_focus;
	gapless_monocle;
	borderless_monocle;
	normal_border_color;
	center_pseudo_tiled;
	split_ratio;
	single_monocle;
}

typedef TRule = {
	@:optional var app:String;
	@:optional var state:String;
	@:optional var desktop:String;
	@:optional var follow:String;
	@:optional var manage:String;
	@:optional var focus:String;
}
