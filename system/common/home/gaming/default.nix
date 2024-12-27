{
  stylix = {
    targets = {
      steam = {
        enable = true;
        adwaitaForSteam.enable = true;
      };
    };
    programs.mangohud = {
      enable = true;
      #enableSessionWide = true;

      # settings = {
      #   fps_limit = "150,60,0";
      #   vsync = 1;
      #   cpu_stats = true;
      #   cpu_temp = true;
      #   gpu_stats = true;
      #   gpu_temp = true;
      #   vulkan_driver = true;
      #   fps = true;
      #   frametime = true;
      #   frame_timing = true;
      #   font_size = 24;
      #   position = "top-left";
      #   engine_version = true;
      #   wine = true;
      #   no_display = true;
      #   background_alpha = "0.5";
      #   toggle_fps_limit = "Shift_R+F1";
      #   toggle_hud = "Shift_R+F2";
    };
  };
}
