{pkgs, ...}: {
  imports = [../environment];
  home-manager.users.nyx = {
    imports = [./niri-binds];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        input = {
          touchpad = {
            dwt = true;
            tap = true;
            natural-scroll = true;
            #click-method = "clickfinger";
          };
          mouse.natural-scroll = false;
          tablet.map-to-output = "eDP-1";
          touch.map-to-output = "eDP-1";
          focus-follows-mouse.enable = true;
          warp-mouse-to-focus = true;
        };

        hotkey-overlay.skip-at-startup = true;
        layout = {
          gaps = 12;
          focus-ring = {
            enable = true;
            width = 5;
          };

          border = {
            enable = true;
            width = 5;
          };
        };
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%s.png";

        spawn-at-startup = [
          {command = ["firefox"];}
          {command = ["element-desktop"];}
          {command = ["webcord"];}
          {command = ["telegram-desktop"];}
          {command = ["thunderbird"];}
        ];
        window-rules = [
          {
            clip-to-geometry = true;
            geometry-corner-radius = {
              top-left = 12.0;
              top-right = 12.0;
              bottom-left = 12.0;
              bottom-right = 12.0;
            };
          }
        ];
      };
    };
  };
  # environment = {
  #   systemPackages = with pkgs; [
  #     # portals
  #     xdg-desktop-portal
  #     xdg-desktop-portal-gnome
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gtk
  #     gnome-keyring
  #   ];
  # };
}
