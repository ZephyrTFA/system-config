{
  description = "A template that shows all standard flake outputs";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    colmena.url = "github:zhaofengli/colmena";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    fenix,
    nixpkgs,
    colmena,
    ...
  }: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
          overlays = [fenix.overlays.default];
        };
      };

      derg-nix = {
        deployment = {
          targetHost = "derg-nix";
          targetPath = "/etc/nixos";
        };
        imports = [
          ./systems/derg-nix
        ];
      };
    };

    packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
    nixosConfigurations.derg-nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({pkgs, ...}: {
          nixpkgs.overlays = [fenix.overlays.default];
        })
        ./home
        ./programs
        ./services
        ./system
      ];
    };
  };
}
