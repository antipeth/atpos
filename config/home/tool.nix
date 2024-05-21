{pkgs, lib, ...}:
let
  inherit (import ../../options.nix) tool ;
in lib.mkIf (tool == true) {
  home.packages = with pkgs; [
    nmap nmapsi4 rustscan
    metasploit armitage
    whois
  ];
}
