{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.wluma = {
    Unit = {
      Description = pkgs.wluma.meta.description;
      After = "graphical-session.target";
      PartOf = "graphical-session.target";
    };
    Service = {
      ExecStart = lib.getExe pkgs.wluma;
      Environment = "RUST_LOG=debug";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  xdg.configFile."wluma/config.toml".source = (pkgs.formats.toml {}).generate "wluma-config" {
    als = {
      # iio = { path = "/sys/bus/iio/devices";
      #   thresholds = { # should be decent devaults already so .... idk
      #     "0" = "night";
      #     "10" = "dark";
      #     "20" = "dim";
      #     "100" = "normal";
      #     "200" = "bright";
      #     "500" = "outdoors";
      #   };
      # };
      none.thresholds = {
        # should be decent devaults already so .... idk
        "1000" = "night";
        "1500" = "dark";
        "2000" = "dim";
        "5000" = "normal";
        "10000" = "bright";
        "19200" = "outdoors";
      };
    };

    output.backlight = [
      {
        #capturer = "none"; # TODO: test if this should be set instead
        capturer = "wayland";
        name = "eDP-1";
        path = "/sys/class/backlight/intel_backlight";
      }
    ];
  };
}
