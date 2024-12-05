{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."wluma/config.toml".text = ''
    [als.iio]
    path = "/sys/bus/iio/devices"
    thresholds = { 100 = "night", 120 = "dark", 180 = "dim", 250 = "normal", 500 = "bright", 800 = "outdoors" }

    [[output.backlight]]
    name = "eDP-1"
    path = "/sys/class/backlight/intel_backlight"
    capturer = "wayland"
  '';

  systemd.user.services.wluma = {
    Unit = {
      Description = pkgs.wluma.meta.description;
      After = "graphical-session.target";
      PartOf = "graphical-session.target";
    };
    Service = {
      Environment = "RUST_LOG=debug";
      ExecStart = lib.getExe pkgs.wluma;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
