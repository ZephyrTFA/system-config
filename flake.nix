{
  description = "A template that shows all standard flake outputs";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix/0.15.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    colmena.url = "github:zhaofengli/colmena/v0.4.0";
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    fenix,
    nixpkgs,
    nixpkgs-unstable,
    colmena,
    ...
  }: {
    imports = [
      ./cachix.nix
    ];

    home-manager.backupFileExtension = "bak";
    colmena = let
      nixpkg-config = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [fenix.overlays.default];
      };
    in {
      meta = {
        nixpkgs = import nixpkgs nixpkg-config;
        specialArgs.pkgs-unstable = import nixpkgs-unstable nixpkg-config;
      };

      derg-nix = {
        deployment.allowLocalDeployment = true;
        imports = with inputs; [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ./systems/derg-nix
        ];
      };
    };
  };
}
