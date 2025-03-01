{pkgs, ...}: {
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [gh];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
