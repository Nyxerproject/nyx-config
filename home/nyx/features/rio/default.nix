{config, ...}: {
  programs.rio = {
    enable = true;
    settings =
      {
        hide-cursor-when-typing = true;
        #cursor = "▇";
        #blinking-cursor = true;
        #theme = "default";
        # padding-x = 4;
        window = {
          decorations = "Disabled";
          #decorations = "Transparent";
          mode = "Maximized";
        };
        colors = with config.lib.stylix.colors.withHashtag; {
          background = base00;
          foreground = base05;
          selection-background = base02;
          selection-foreground = base05;
          cursor = base05;
          black = base00;
          white = base05;
          inherit red green yellow blue magenta cyan;
          light_black = base03;
          light_white = base07;
          light_red = bright-red;
          light_green = bright-green;
          light_yellow = yellow;
          light_blue = bright-blue;
          light_magenta = bright-magenta;
          light_cyan = bright-cyan;
        };
        renderer = {
          performance = "High";
          backend = "Vulkan"; # or "Automatic"
          disable-unfocused-render = false;
        };
        confirm-before-quit = false;
        navigation = {
          mode = "CollapsedTab";
          #mode = "TopTab";
          clickable = true;
          open-config-with-split = true;
          use-split = true;
          color-automation = [
            {
              program = "nvim";
              color = "#FF0000";
            }
            {
              program = "nyx-rebuild";
              color = "#FFFF00";
            }
            {
              program = "ssh";
              color = "#00FF00";
            }
            {
              program = "zellij";
              color = "#00FFFF";
            }
            {
              path = "/home/nyx/nyx-config";
              color = "#0000FF";
            }
            {
              program = "nvim";
              path = "/home/nyx/nyx-config";
              color = "#FF00FF";
            }
          ];
        };
        shell = {
          program = "fish";
          args = [];
        };
        fonts.family = config.stylix.fonts.monospace.name;
      }
      // {
        window = {
          opacity = with config.stylix.opacity; terminal;
          blur = true;
        };
        fonts = with config.stylix.fonts; {
          regular = {
            family = monospace.name;
            style = "normal";
            width = "Normal";
            weight = 400;
          };
          bold = {
            family = monospace.name;
            style = "normal";
            width = "Normal";
            weight = 800;
          };
          italic = {
            family = monospace.name;
            style = "normal";
            width = "Normal";
            weight = 400;
          };
          bold-italic = {
            family = monospace.name;
            style = "normal";
            width = "Normal";
            weight = 800;
          };
        };
        # navigation = {
        #   color-automation = [];
        # };
        colors = with config.lib.stylix.colors.withHashtag; {
          background = base00;
          foreground = base05;
          selection-background = base02;
          selection-foreground = base05;
          cursor = base05;
          black = base00;
          white = base05;
          inherit red green yellow blue magenta cyan;
          light_black = base03;
          light_white = base07;
          light_red = bright-red;
          light_green = bright-green;
          light_yellow = yellow;
          light_blue = bright-blue;
          light_magenta = bright-magenta;
          light_cyan = bright-cyan;
        };
      };
  };
}
