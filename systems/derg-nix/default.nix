{pkgs, ...}: {
  imports = [
    ../../users/derg.nix
    ../../programs/tuxclocker.nix
    ./services
    ./system
  ];
  virtualisation.podman.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    direnv
    podman
  ];
}
