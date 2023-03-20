@:build(utils.Utils.build_config_opts())
class Config {
	public static var wm_name:String;
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
