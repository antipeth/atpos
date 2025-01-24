{ host, ... }:
let
  inherit (import ../hosts/${host}/variables.nix) gitUsername gitEmail;
in
{
  # Install & Configure Git
  programs = {
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
    gh.enable = true;
  };
}
