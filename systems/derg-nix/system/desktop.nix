{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs; [
    sysprof
  ];
  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];
  services.sysprof.enable = true;
  environment.shells = with pkgs; [fish];
}
