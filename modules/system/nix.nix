{
  inputs,
  lib,
  ...
}:
with lib; {
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix = {
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      connect-timeout = 5;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      gc-keep-derivations = false;
      gc-keep-outputs = false;
      keep-going = true;
      log-lines = 25;
      nix-path = mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      substituters = [
        # "https://cache.0pt.de5.net"
        # "https://cache.garnix.io"
        "https://cache.nixos.org"
        # "https://chaotic-nyx.cachix.org"
        "https://nix-community.cachix.org"
        # "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        # "cache.0pt.de5.net:/Hyi1uycfWDHlTBga1ni3vqsK69wlblu0HeruHfEfOk="
        # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
      warn-dirty = false;
    };
  };
}
