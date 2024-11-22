{pkgs, ...}: {
  programs.rio.enable = true;
  programs.rio.settings = {
    cursor = "▇";
    blinking-cursor = false;
    window = {
      foreground-opacity = 1.0;
      background-opacity = 0.96;
      blur = true;
      decorations = "Disabled";
    };
    fonts = {
      size = 10;
    };
    shell = {
      program = "${pkgs.zellij}/bin/zellij";
      args = ["-s" "local-dev" "attach" "-c" "local-dev"];
    };
  };
}
