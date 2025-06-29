{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./audio.nix ./desktop.nix ./filesystem.nix ./nvidia.nix];

  system.stateVersion = "25.05";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];

  time.timeZone = "America/New_York";

  networking.networkmanager.enable = true;
  networking.hostName = "derg-nix";
  networking.hostId = "6a2e7645";
  networking.useDHCP = lib.mkDefault true;
  programs.mtr.enable = true;
}
