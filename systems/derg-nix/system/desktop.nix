{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
  };
  environment.systemPackages = [pkgs.xfce.xfce4-whiskermenu-plugin];
}
