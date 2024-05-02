{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./neofetch.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];

}
