local dap = require('dap')
dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = {os.getenv('HOME').."/dev/projects/Dart-Code/out/dist/debug.js", "flutter"}
  }
dap.configurations.dart = {
	{
	  type = "dart",
	  request = "launch",
	  name = "Launch flutter",
	  dartSdkPath = os.getenv('HOME').."/dev/projects/flutter/bin/cache/dart-sdk/",
	  flutterSdkPath = os.getenv('HOME').."/dev/projects/flutter",
	  program = "${workspaceFolder}/lib/main.dart",
	  cwd = "${workspaceFolder}",
	}
}
