{pkgs, ...}: {
  imports = [
    ../../users/derg.nix
    ../../programs/tuxclocker.nix
    ./services
    ./system
  ];
  virtualisation.podman.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    direnv
    podman
  ];
}
