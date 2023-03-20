/**
	TODO: THIS PROJECT WILL TRY TO GLOBALLY USE SXHD AS THE ONLY HOTKEY
	DAEMON BECAUSE ITS ALMOST IMPOSSIBLE TO DO THAT WITH EACH WM'S
	OUT OF THE OVEN SOLUTION.
**/
class KeyBinder {
	public static function bind_key_to_action() {}

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
