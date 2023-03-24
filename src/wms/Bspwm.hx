package wms;

class Bspwm {}

class BspwmConfig {
	public static function set_border_width(width:String):String {
		return bspc(Config(ConfigOptions.BorderWidth(4)));
	}

	public static function set_active_border_color(value:String) {
		return bspc(Config((ConfigOptions.ActiveBorderColor(value))));
	}

	public static function set_bottom_padding(value:Int) {
		return bspc(Config(ConfigOptions.BottomPadding(value)));
	}

	public static function click_to_focus(bool:Bool) {
		return bspc(Config(ConfigOptions.ClickToFocus(bool)));
	}

	public static function set_focused_border_color(value:String) {
		return bspc(Config(ConfigOptions.FocusedBorderColor(value)));
	}

	public static function set_focus_follows_pointer(bool:Bool) {
		return bspc(Config(ConfigOptions.FocusFollowsPointer(bool)));
	}

	public static function set_left_padding(value:Int) {
		return bspc(Config(ConfigOptions.LeftPadding(value)));
	}

	public static function set_right_padding(value:Int) {
		return bspc(Config(ConfigOptions.RightPadding(value)));
	}

	public static function set_top_padding(value:Int) {
		return bspc(Config(ConfigOptions.TopPadding(value)));
	}

	public static function set_normal_border_color(value:String) {
		return bspc(Config(ConfigOptions.NormalBorderColor(value)));
	}

	public static function set_split_ratio(value:Int) {
		return bspc(Config(ConfigOptions.SplitRatio(value)));
	}

	public static function set_window_gap(value:Int) {
		return bspc(Config(ConfigOptions.WindowGap(value)));
	}

	public static function bspc(arg:BspcArgument) {
		return "bspc " + resolve_bspc_arg(arg);
	}

	public static function resolve_config_option(config:ConfigOptions) {
		return switch config {
			case ActiveBorderColor(value):
				"active_border_color " + value;
			case BorderWidth(value):
				"border_width " + value;
			case BottomPadding(value):
				"bottom_padding " + value;
			case ClickToFocus(bool):
				"click_to_focus " + bool;
			case FocusedBorderColor(value):
				"focused_border_color " + value;
			case FocusFollowsPointer(bool):
				"focus_follows_pointer " + bool;
			case LeftPadding(value):
				"left_padding " + value;
			case RightPadding(value):
				"right_padding " + value;
			case TopPadding(value):
				"top_padding " + value;
			case NormalBorderColor(value):
				"normal_border_color " + value;
			case SplitRatio(value):
				"split_ratio " + value;
			case WindowGap(value):
				"window_gap " + value;
		}
	}

	public static function resolve_bspc_arg(arg:BspcArgument) {
		return switch arg {
			case Config(option):
				"config " + resolve_config_option(option);
		}
	}
}

enum BspcArgument {
	Config(option:ConfigOptions);
}

enum ConfigOptions {
	ActiveBorderColor(value:String);
	BorderWidth(value:Int);
	BottomPadding(value:Int);
	ClickToFocus(bool:Bool);
	FocusedBorderColor(value:String);
	FocusFollowsPointer(bool:Bool);
	LeftPadding(value:Int);
	RightPadding(value:Int);
	TopPadding(value:Int);
	NormalBorderColor(value:String);
	SplitRatio(value:Int);
	WindowGap(value:Int);
}

class BspwmRule {}
