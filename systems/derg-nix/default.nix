{pkgs, ...}: {
  imports = [
    ../../users/derg.nix
    ../../programs/tuxclocker.nix
    ./services
    ./system
  ];
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    podman
    podman-tui
    podman-compose
    direnv
  ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };
}
