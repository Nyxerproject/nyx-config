{
  programs = {
    alacritty = {
      enable = true;
      # TODO create alacritty nix file (or better yet options like in the vimjoyer)
      settings = {
        env.TERM = "xterm-256color";
        font.size = 12;
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };
  };
}
