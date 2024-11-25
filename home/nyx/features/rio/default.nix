{pkgs, ...}: {
  programs.rio = {
    enable = true;
    settings = {
      #cursor = "▇";
      #blinking-cursor = false;
      #theme = "default";
      window = {
        foreground-opacity = 1.0;
        background-opacity = 0.96;
        blur = true;
        decorations = "Disabled";
      };
      fonts = {
        family = "FiraCode Nerd Font";
        #size = 15;
      };
      # shell = {
      #   program = "${pkgs.zellij}/bin/zellij";
      #   args = ["-s" "local-dev" "attach" "-c" "local-dev"];
      # };
    };
  };
}