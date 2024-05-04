{ pkgs, lib, ... }:

let inherit (import ../../options.nix) blender; in
lib.mkIf (blender == true) {
  home.packages = with pkgs; [
    blender-hip
  ];
}
