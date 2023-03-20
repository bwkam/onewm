import sys.io.File;
import haxe.macro.Context;

using StringTools;
using haxe.macro.ExprTools;
using Lambda;

class Rule {
	macro public static function add_rule(name:haxe.macro.Expr) {
		var rule = Globals.wm_name == "bspwm" ? "bspc rule -a" : "for_window";
		switch name.expr {
			case EObjectDecl(fields):
				if (Context.unify(Context.typeof(name), Context.getType('Rule.TRule'))) {
					var fld_names = fields.map(e -> e.field);
					var cnt = 0;
					Globals.wm_name == "bspwm" ? (for (f in fields) {
						rule = '$rule ${fld_names[cnt]}=${f.expr.toString()}';
						cnt++;
					}) : {
						// rule = '$rule ${fld_names[cnt]}=${f.expr.toString()}';
						// for ()
						// trace('$rule [${}]');
						// rule = '$rule [${fields.find(e -> e.field == "app")}]';
						trace(bindsym(true, null, Mod3, "r", ToggleFloating));
						cnt++;
					};

					rule = rule + '\n';
				}
			default:
				haxe.macro.Context.error('Invalid expression', name.pos);
		}

		File.append("config", false).writeString(rule);

		return macro null;
	}

	public static function bindsym(release:Bool = false, ?group:String = "", ?mod:Mod = None, keysym:String, action:Action):String {
		return 'bindsym ${release ? " --release " : ""} $group${group == "" ? "" : "+"}${resolve_mod(mod)}+$keysym ${resolve_action(action)}';
	}

	public static function resolve_mod(mod:Mod) {
		return switch (mod) {
			case Mod1:
				"Mod1";
			case Mod2:
				"Mod2";
			case Mod3:
				"Mod3";
			case Mod4:
				"Mod4";
			case Mod5:
				"Mod5";
			case Shift:
				"Shift";
			case None:
				"";
			case Control:
				"Control";
		}
	}

	public static function resolve_action(action:Action) {
		return switch (action) {
			case Exec(command):
				"exec " + command;
			case ToggleFullscreen:
				"fullscreen toggle";
			case ChangeMode(mode):
				"mode " + mode;
			case ToggleFloating:
				"floating toggle";
			case Builtin(command):
				command;
			case Move(direction):
				return switch (direction) {
					case Left:
						"move left";
					case Right:
						"move right";
					case Up:
						"move up";
					case Bottom:
						"move bottom";
				}
		}
	}
}

typedef TRule = {
	@:optional var app:String;
	@:optional var state:String;
	@:optional var desktop:String;
	@:optional var follow:String;
	@:optional var manage:String;
	@:optional var focus:String;
}

enum Mod {
	Mod1;
	Mod2;
	Mod3;
	Mod4;
	Mod5;
	Shift;
	None;
	Control;
}

enum Action {
	Exec(command:String);
	ToggleFullscreen;
	ChangeMode(mode:String);
	Move(direction:Direction);
	ToggleFloating;
	Builtin(command:String);
}

enum Direction {
	Left;
	Right;
	Up;
	Bottom;
}
