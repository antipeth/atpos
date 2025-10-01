{
  description = "AtpOS";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake/flake.nix";
  };

  outputs = {
    chaotic,
    daeuniverse,
    nixpkgs,
    nixvim,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "icemonkey";
    username = "atp";
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
        };
        modules = [
          ./hosts/${host}/config.nix
          chaotic.nixosModules.default
          daeuniverse.nixosModules.daed
          inputs.disko.nixosModules.disko
          inputs.stylix.nixosModules.stylix
          nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit inputs;
              inherit host;
              inherit nixvim;
            };
            home-manager.users.${username} = import ./hosts/${host}/home.nix;
          }
          # microvm.nixosModules.host
          # {
          #   microvm.vms = {
          #     test-microvm = {
          #       pkgs = import nixpkgs { system = "x86_64-linux"; };
          #       config = import ./hosts/${host}/vm.nix;
          #     };
          #   };
          # }
        ];
      };
    };
    openwrt-env = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in
      pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          git
          pkg-config
          ncurses
          unzip
          python3
          cdrtools
          perl
          rsync

          python3Packages.setuptools
          swig
        ];
        hardeningDisable = ["all"];
      };
  };
}
