{config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # you would think these are enable by default.
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # explicitly tell xserver to use nvidia over software rendering
  services.xserver.videoDrivers = ["nvidia"];
  # text based mode needs the same hint
  boot.initrd.kernelModules = ["nvidia"];

  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
  };
}
