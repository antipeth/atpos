{
  description = "AtpOS";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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

  };

  outputs =
    {
      chaotic,
      nixpkgs,
      nixvim,
      home-manager,
      microvm,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      host = "asusbook";
      username = "atp";
    in
    {
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
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              # home-manager.backupFileExtension = "backup";
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
    };
}
