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

  home-manager.users.derg = {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };

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

    home.packages = with pkgs; [
      kdePackages.konsole
      vscode
      spotify
      (fenix.packages.x86_64-linux.stable.completeToolchain)
      ((import ../programs/prism.nix {inherit lib pkgs;}).prism)
    ];
    home.stateVersion = config.system.stateVersion;
  };
}
