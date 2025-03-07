{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [../environment];
  programs.niri.enable = true; # WARNING: THIS IS NEEDED!!!!
  home-manager.users.nyx = {
    imports = [./niri-binds];
    programs.niri = {
      # WARNING: Do not use 'home-manager.users.me.programs.niri.enable = true'
      # Niri-flake doesn't have that setting, but it does require
      # 'programs.niri.enable = true' system wide
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

        environment.DISPLAY = ":0";
        spawn-at-startup = [
          {command = ["firefox"];}
          {command = ["keepassxc"];}
          # {command = ["element-desktop"];}
          # {command = ["webcord"];}
          # {command = ["telegram-desktop"];}
          # {command = ["thunderbird"];}
          {
            command = [
              "${lib.getExe pkgs.swaybg}"
              "--mode"
              "fill"
              "--image"
              "${config.stylix.image}"
            ];
          }
          # {command = ["bash" "-c" "export" "$(dbus-launch)"];} # TODO: Figure out what this does. Why do did I put these here?
          # {command = ["bash" "-c" "xwayland-satellite" "&"];}
          {command = ["${lib.meta.getExe pkgs.xwayland-satellite-unstable}"];}
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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      # xwayland-satellite-unstable
      # swaybg
      # xwayland
      # # portals
      # xdg-desktop-portal
      # xdg-desktop-portal-gnome
      # xdg-desktop-portal-wlr
      # xdg-desktop-portal-gtk
      # gnome-keyring
    ];
  };
}
