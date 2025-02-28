{...}: {
  programs.tuxclocker = {
    enable = true;
    nvidia = {
      enable = true;
      useUnfree = true;
    };
  };
}
