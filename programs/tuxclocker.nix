{pkgs, ...}: {
  programs.tuxclocker = {
    enable = true;
    useUnfree = true;
  };

  systemd.services."tuxclockerd" = {
    enable = true;
    description = "TuxClocker daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.tuxclocker}/bin/tuxclockerd";
      Restart = "always";
      RestartSec = "5";
    };
  };
}
