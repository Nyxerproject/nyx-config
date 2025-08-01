{
  home-manager.users.nyx = {
    programs.niri.settings.outputs = {
      "Acer Technologies Acer XFA240 0x01826F9E" = {
        mode = {
          height = 1080;
          width = 1920;
          refresh = 144.001;
        };
        position = {
          x = 0;
          y = 0;
        };
      };

      "Hewlett Packard HP Z24x CN44440B42" = {
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
    };
  };
}
