{ pkgs }:

pkgs.writeShellScriptBin "anyrun-launcher" ''
  if pgrep -x "anyrun" > /dev/null; then
    # Rofi is running, kill it
    pkill -x anyrun
    exit 0
  fi
  anyrun
''
