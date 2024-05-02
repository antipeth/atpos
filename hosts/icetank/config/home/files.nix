{ pkgs, config, ... }:

{
  home.file.".config/starship.toml".source = ./files/starship.toml;
}
