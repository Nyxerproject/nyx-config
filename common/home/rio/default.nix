{lib, ...}: {
  programs.rio = {
    enable = true;
    settings = {
      hide-cursor-when-typing = true;
      # cursor = "▇";
      # blinking-cursor = true;
      # padding-x = 4;
      # window = {
      #   decorations = "Disabled";
      #   #decorations = "Transparent";
      #   mode = "Maximized";
      # };
      renderer = {
        performance = "High";
        # backend = "Vulkan"; # or "Automatic"
        disable-unfocused-render = false;
      };
      fonts = lib.mkForce {
        family = lib.mkforce "FiraCode Nerd Font";
        #italic.family = "Victor Mono NF";
        extra = {
          family = "Noto Color Emoji";
        };
      };
      use-fork = true;
      shell = {
        program = "fish";
        args = [];
      };
      navigation = {
        #mode = "CollapsedTab";
        mode = "TopTab";
        clickable = true;
        open-config-with-split = true;
        use-split = true;
      };
    };
  };
}
