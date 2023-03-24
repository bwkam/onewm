import wms.Bspwm.BspwmConfig;

using haxe.macro.ExprTools;
using Lambda;

class Main {
	static function main() {
		trace(BspwmConfig.set_border_width("10"));
	}
}
