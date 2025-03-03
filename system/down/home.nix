{
  home-manager.users.nyx = {
    programs.niri.settings = {
      outputs."eDP-1" = {
        mode = {
          height = 1080;
          width = 1920;
          refresh = 60.0;
        };
        scale = 0.9;
        position = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
