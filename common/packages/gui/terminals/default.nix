{lib, ...}: {
  programs.rio = {
    enable = true;
    settings = {
      hide-cursor-when-typing = true;
      renderer = {
        performance = "High";
        disable-unfocused-render = false;
      };
      confirm-before-quit = false;
      fonts = lib.mkForce {
        family = "FiraCode Nerd Font";
        extra.family = "Noto Color Emoji";
      };
      shell.program = "fish";
      navigation = {
        mode = "Bookmark";
        clickable = true;
        open-config-with-split = true;
        use-split = true;
      };
    };
  };
}
