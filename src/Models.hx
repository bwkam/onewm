typedef JsonModel = {
	var workspaces:Array<String>;
	var rules:Array<Map<String, RuleModel>>;
	var config:Map<String, ConfigModel>;
}

typedef ConfigModel = {
	@:optional var border_width:String;
	@:optional var window_gap:String;
	@:optional var active_border_color:String;
	@:optional var focus_follows_pointer:String;
	@:optional var focused_border_color:String;
	@:optional var left_padding:String;
	@:optional var left_monocle_padding:String;
	@:optional var right_padding:String;
	@:optional var right_monocle_padding:String;
	@:optional var top_padding:String;
	@:optional var top_monocle_padding:String;
	@:optional var pointer_follows_focus:String;
	@:optional var pointer_follows_monitor:String;
	@:optional var click_to_focus:String;
	@:optional var gapless_monocle:String;
	@:optional var borderless_monocle:String;
	@:optional var normal_border_color:String;
	@:optional var center_pseudo_tiled:String;
	@:optional var split_ratio:String;
	@:optional var single_monocle:String;
}

typedef RuleModel = {
	@:optional var app:String;
	@:optional var state:String;
	@:optional var desktop:String;
	@:optional var follow:String;
	@:optional var manage:String;
	@:optional var focus:String;
}
