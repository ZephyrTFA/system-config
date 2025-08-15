{config, ...}: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia" "modesetting"];
  services.hardware.bolt.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
