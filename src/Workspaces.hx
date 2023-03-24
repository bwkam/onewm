import sys.io.File;

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
