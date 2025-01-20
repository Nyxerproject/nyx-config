{
  home-manager.users.nyx = {
    programs.niri.settings = {
      switch-events = {
        # tablet-mode-on.action.spawn = ["wvkbd-mobintl"];
        # tablet-mode-off.action.spawn = ["kill -s 2 $(ps -C wvkbd-mobintl)"];
      };
      outputs."eDP-1" = {
        mode = {
          height = 1080;
          width = 1920;
          refresh = 60.0;
        };
        scale = 0.8;
        position = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
