{
  home-manager.users.nyx = {
    programs.niri.settings = {
      outputs."DP-2" = {
        mode = {
          height = 1200;
          width = 1920;
          refresh = 60.0;
        };
        transform.rotation = 270;
        position = {
          x = 1920;
          y = -540;
        };
      };
      outputs."DP-3" = {
        mode = {
          height = 1080;
          width = 1920;
          refresh = 144.01;
        };
        position = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
