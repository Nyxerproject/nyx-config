{pkgs, ...}: {
  programs.rio = {
    enable = true;
    settings = {
      #cursor = "▇";
      #blinking-cursor = false;
      #theme = "default";
      window = {
        foreground-opacity = 1.0;
        background-opacity = 0.6;
        blur = true;
        decorations = "Disabled";
      };
      # fonts = {
      #   family = "FiraCode Nerd Font";
      #   #size = 15;
      # };
      fonts = {
        size = 10;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Bold_Italic";
        };
      };

      # shell = {
      #   program = "${pkgs.zellij}/bin/zellij";
      #   args = ["-s" "local-dev" "attach" "-c" "local-dev"];
      # };
    };
  };
}
