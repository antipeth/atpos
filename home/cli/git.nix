{host, ...}: let
  inherit (import ../../hosts/${host}/env.nix) gitUsername gitEmail;
in {
  # Install & Configure Git
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };
    };
    gh.enable = true;

    lazygit.enable = true;
  };
}
