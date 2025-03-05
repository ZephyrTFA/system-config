{
  config,
  fenix,
  pkgs,
  home-manager,
  ...
}: {
  users.users.derg = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    home = "/persist/user-homes/derg";
  };

  programs.steam.enable = true;
  programs.fish.enable = true;

  home-manager.users.derg.services.kdeconnect.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  home-manager.users.derg = {
    gtk.enable = true;
    gtk.theme.package = pkgs.gnome-themes-extra;
    gtk.theme.name = "Adwaita-dark";

    programs = {
      firefox.enable = true;
      fish = {
        enable = true;
        shellInit = ''
          set fish_greeting
          ${pkgs.starship}/bin/starship init fish | source
        '';
      };
      git = {
        enable = true;
        userName = "ZephyrTFA";
        userEmail = "matthew@tfaluc.com";
      };
      gpg.enable = true;
      vim.enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      extraConfig = ''
        pinentry-program ${pkgs.pinentry}/bin/pinentry
      '';
    };

    home.packages = with pkgs; [
      kdePackages.konsole
      vscode
      spotify
      vesktop
      (fenix.packages.x86_64-linux.stable.completeToolchain)
      ((import ../programs/prism.nix {inherit lib pkgs;}).prism)
    ];
    home.stateVersion = config.system.stateVersion;
  };
}
