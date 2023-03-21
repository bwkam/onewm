package wms;

class I3 {}

class I3Config {
	public static function set_border_width(mode:BorderArgs) {
		return i3_msg(Actions.DefaultBorder(mode));
	}

	public static function set_default_floating_border(mode:BorderArgs, value:Int) {
		return i3_msg(Actions.DefaultFloatingBorder(mode, value));
	}

	public static function set_smart_borders(value:SmartBordersArgs) {
		return i3_msg(Actions.SmartBorders(value));
	}

	public static function set_hide_edge_borders(value:HideEdgeBorders) {
		return i3_msg(Actions.HideEdgeBorders(value));
	}

	public static function set_title_align(align:TitleAlignArgs) {
		return i3_msg(Actions.TitleAlign(align));
	}

	public static function set_workspace_layout(layout:WorkspaceLayoutArgs) {
		return i3_msg(Actions.WorkspaceLayout(layout));
	}

	public static function set_floating_min_size(width:String, height:String) {
		return i3_msg(Actions.FloatingMinSize(width, height));
	}

	public static function set_floating_max_size(width:String, height:String) {
		return i3_msg(Actions.FloatingMaxSize(width, height));
	}

	public static function set_floating_modifier(mod:ModKeys) {
		return i3_msg(Actions.FloatingModifier(mod));
	}

	public static function set_move_to_workspace_direction(direction:WorkspaceDirection) {
		return i3_msg(Actions.MoveToWorkspaceDirection(direction));
	}

	public static function set_move_to_workspace_back_and_forth() {
		return i3_msg(Actions.MoveToWorkspaceBackAndForth);
	}

	public static function set_move_to_workspace_name(name:String) {
		return i3_msg(Actions.MoveToWorkspaceName(name));
	}

	public static function set_move_to_workspace_number_name(name:String) {
		return i3_msg(Actions.MoveToWorkspaceNumberName(name));
	}

	public static function set_assign(name:String, workspace:String) {
		return i3_msg(Actions.Assign(name, workspace));
	}

	public static function set(name:String, value:String) {
		return i3_msg(Actions.Set(name, value));
	}

	public static function exec(no_startup_id:Bool, command:String) {
		return i3_msg(Actions.Exec(no_startup_id, command));
	}

	public static function i3_msg(action:Actions) {
		return "i3-msg " + resolve_action(action);
	}

	public static function resolve_action(action:Actions) {
		return switch action {
			case DefaultBorder(mode):
				"default_border " + resolve_border_arg(mode);
			case DefaultFloatingBorder(mode, value):
				"default_floating_border " + resolve_border_arg(mode) + value;
			case SmartBorders(value):
				"smart_borders " + resolve_smart_border_arg(value);
			case HideEdgeBorders(value):
				"hide_edge_borders " + resolve_hide_edge_border_arg(value);
			case TitleAlign(align):
				"title_align " + resolve_title_align(align);
			case WorkspaceLayout(layout):
				"workspace_layout " + resolve_workspace_layout_arg(layout);
			case FloatingMinSize(width, height):
				"floating_minumum_size " + '$width ' + height;
			case FloatingMaxSize(width, height):
				"floating_maximum_size " + '$width ' + height;
			case FloatingModifier(mod):
				"floating_modifier " + resolve_mod(mod);
			case ForWindow(name, action):
				'for_window [class=^"$name"] ${resolve_action(action)}';
			case MoveToWorkspaceDirection(direction):
				'workspace ${resolve_workspace_directon(direction)}';
			case MoveToWorkspaceBackAndForth:
				'workspace back_and_forth';
			case MoveToWorkspaceName(name):
				'workspace $name';
			case MoveToWorkspaceNumberName(name):
				'workspace number $name';
			case Assign(name, workspace):
				'assign [class=^"$name"] $workspace';
			case Set(name, value):
				'set $name $value';
			case Exec(no_startup_id, command):
				"exec " + (no_startup_id == true ? "--no-startup-id " : "") + command;
		}
	}

	public static function resolve_workspace_layout_arg(arg:WorkspaceLayoutArgs) {
		return switch arg {
			case Horizontal:
				"horizontal";
			case Vertical:
				"vertical";
			case Auto:
				"auto";
		}
	}

	public static function resolve_title_align(title:TitleAlignArgs) {
		return switch title {
			case Left:
				"left";
			case Center:
				"center";
			case Right:
				"right";
		}
	}

	public static function resolve_hide_edge_border_arg(arg:HideEdgeBorders) {
		return switch arg {
			case None:
				"none";
			case Vertical:
				"vertical";
			case Horizontal:
				"horizontal";
			case Both:
				"both";
			case Smart:
				"smart";
			case SmartNoGaps:
				"smart_no_gaps";
		}
	}

	public static function resolve_smart_border_arg(arg:SmartBordersArgs) {
		return switch arg {
			case On:
				"on";
			case Off:
				"off";
			case NoGaps:
				"no_gaps";
		}
	}

	public static function resolve_border_arg(arg:BorderArgs) {
		return switch arg {
			case Normal:
				"normal";
			case None:
				"none";
			case Pixel(value):
				"pixel " + value;
		}
	}

	public static function resolve_mod(mod:ModKeys) {
		return switch mod {
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
			case Control:
				"Control";
			case Alt:
				"Alt";
			case Shift:
				"Shift";
		}
	}

	public static function resolve_workspace_directon(direction:WorkspaceDirection) {
		return switch direction {
			case Next:
				"next";
			case Prev:
				"prev";
			case NextOnOutput:
				"next_on_output";
			case PrevOnOutput:
				"prev_on_output";
		}
	}
}

class I3Rule {
	public static function add_rule(window_class:String, action:Actions) {
		return I3Config.i3_msg(Actions.ForWindow(window_class, action));
	}
}

enum Actions {
	DefaultBorder(mode:BorderArgs);
	DefaultFloatingBorder(mode:BorderArgs, value:Int);
	SmartBorders(value:SmartBordersArgs);
	HideEdgeBorders(value:HideEdgeBorders);
	ForWindow(name:String, action:Actions);
	TitleAlign(align:TitleAlignArgs);
	WorkspaceLayout(layout:WorkspaceLayoutArgs);
	FloatingMinSize(width:String, height:String);
	FloatingMaxSize(width:String, height:String);
	FloatingModifier(mod:ModKeys);
	Assign(name:String, workspace:String);
	MoveToWorkspaceDirection(direction:WorkspaceDirection);
	MoveToWorkspaceName(name:String);
	MoveToWorkspaceNumberName(name:String);
	MoveToWorkspaceBackAndForth;
	Set(name:String, value:String);
	Exec(no_startup_id:Bool, command:String);
}

enum WorkspaceDirection {
	Next;
	Prev;
	NextOnOutput;
	PrevOnOutput;
}

enum WorkspaceLayoutArgs {
	Horizontal;
	Vertical;
	Auto;
}

enum TitleAlignArgs {
	Left;
	Center;
	Right;
}

enum BorderArgs {
	Normal;
	None;
	Pixel(value:Int);
}

enum HideEdgeBorders {
	None;
	Vertical;
	Horizontal;
	Both;
	Smart;
	SmartNoGaps;
}

enum SmartBordersArgs {
	On;
	Off;
	NoGaps;
}

enum ModKeys {
	Mod1;
	Mod2;
	Mod3;
	Mod4;
	Mod5;
	Control;
	Shift;
	Alt;
}
