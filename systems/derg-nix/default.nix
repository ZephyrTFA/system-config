{pkgs, ...}: {
  imports = [
    ../../users/derg.nix
    ../../programs/tuxclocker.nix
    ./services
    ./system
  ];
  environment.systemPackages = with pkgs; [
    alejandra
  ];
}
