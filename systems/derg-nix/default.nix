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
    direnv
  ];
}
