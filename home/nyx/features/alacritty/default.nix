{
  programs = {
    alacritty = {
      enable = true;
      # TODO: create alacritty nix file (or better yet options like in the vimjoyer)
      settings = {
        # env.TERM = "xterm-256color"; # I just don't know what this actully does
        # TODO: read posix docs and see if I need env.TERM

        # TODO: remove this and other fonts. handled by stylix now.
        # font = {
        #   size = 10;
        #   normal = {
        #     family = "FiraCode Nerd Font";
        #     style = "Regular";
        #   };
        #   bold = {
        #     family = "FiraCode Nerd Font";
        #     style = "Bold";
        #   };
        #   italic = {
        #     family = "FiraCode Nerd Font";
        #     style = "Italic";
        #   };
        #   bold_italic = {
        #     family = "FiraCode Nerd Font";
        #     style = "Bold_Italic";
        #   };
        # };

        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };
  };
}
