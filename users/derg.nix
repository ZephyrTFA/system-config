{
  config,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    ../programs/jdk_env.nix
    ../programs/windowsvm.nix
  ];

  users.users.derg = {
    isNormalUser = true;
    extraGroups = ["wheel" "podman" "docker"];
    home = "/persist/user-homes/derg";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPvRq0FC5TOB9c+XRJdx20JUSga76R3Ohni3FH7trzgE derg@derg-nix"
    ];
    shell = pkgs.fish;
  };

  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [proton-ge-bin];
  programs.fish.enable = true;

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

    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        {package = gsconnect;}
        {package = headsetcontrol;}
        {package = appindicator;}
        {package = arc-menu;}
      ];
    };

    home.packages = with pkgs;
      [
        kdePackages.konsole
        vscode
        spotify
        shotgun
        rustup
        telegram-desktop
        ((import ../programs/prism.nix {inherit lib pkgs;}).prism)
        (discord.override {withVencord = true;})
        devenv
        direnv
        wineWowPackages.staging
        winetricks
      ]
      ++ (with gnomeExtensions; [
        gsconnect
        headsetcontrol
        appindicator
        arc-menu
      ]);

    home.file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      linker = "${pkgs.clang}/bin/clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
      [target.i686-unknown-linux-gnu]
      linker = "${pkgs.clang}/bin/clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
    # some cargo crate build scripts hardcode specific tools
    home.file.".local/state/nix/profile/bin/cc".source = "${pkgs.clang}/bin/clang";
    home.file.".local/state/nix/profile/bin/ar".source = "${pkgs.clang}/bin/ar";

    home.stateVersion = config.system.stateVersion;
  };
}
