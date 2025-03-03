{pkgs, ...}: {
  plugins.notify = {
    enable = pkgs.lib.mkDefault true;
    settings.level = "info";
    # settings.background_colour = "#191724";
  };
}
