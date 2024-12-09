{
  config,
  pkgs,
  lib,
  ...
}: let
  defaultKeyBind = import ./niriKeyBind.nix;
in {
  imports = [
    ../moredesktop
  ];
  home.packages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    cage
    gamescope
    swaybg
    xwayland
    kickoff
    xwayland-satellite-unstable
  ];
  programs.niri.settings = {
    input = {
      keyboard.xkb = {
        layout = "us";
        variant = "";
      };
      trackball.enable = true;
      touchpad = {
        dwt = true;
        tap = true;
        natural-scroll = true;
        #click-method = "clickfinger";
      };
      mouse = {
        natural-scroll = false;
        accel-speed = 1.0;
      };
      tablet.map-to-output = "eDP-1";
      touch.map-to-output = "eDP-1";
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = true;
    };

    hotkey-overlay.skip-at-startup = true;

    switch-events = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {
      tablet-mode-on.action = sh "notify-send tablet-mode-on";
      tablet-mode-off.action = sh "notify-send tablet-mode-off";
      lid-open.action = sh "notify-send lid-open";
      lid-close.action = sh "notify-send lid-close";
    };

    layout = {
      gaps = 12;
      #center-focused-column = "never";
      # default-column-width.proportion = 0.5;
      # preset-column-widths = [
      #   {proportion = 0.333;}
      #   {proportion = 0.5;}
      #   {proportion = 0.667;}
      # ];

      # decoration = {
      #   gradient = {
      #     from = "rgb(255, 121, 198)";
      #     to = "rgb(189, 147, 249)";
      #   };
      # };

      # fog of war
      focus-ring = {
        enable = true;
        width = 5;
        # active = {
        #   gradient = {
        #     from = "#FDEFF9";
        #     to = "#EC38BC";
        #     angle = 0;
        #     relative-to = "workspace-view";
        #   };
        # };
        # inactive = {
        #   gradient = {
        #     to = "#03001E";
        #     from = "#7303C0";
        #     angle = 90;
        #     relative-to = "workspace-view";
        #   };
        # };
      };

      border = {
        enable = true;
        width = 5;
        # active = {
        #   gradient = {
        #     from = "#FDEFF9";
        #     to = "#EC38BC";
        #     angle = 0;
        #     relative-to = "workspace-view";
        #   };
        # };
        #
        # inactive = {
        #   gradient = {
        #     to = "#03001E";
        #     from = "#7303C0";
        #     angle = 90;
        #     relative-to = "workspace-view";
        #   };
        # };
      };
    };
    prefer-no-csd = true;
    environment = {
      #SDL_VIDEO_WAYLAND_PREFER_LIBDECOR = "1";
      DISPLAY = ":0";
    };

    spawn-at-startup = let
      get-wayland-display = "systemctl --user show-environment | awk -F 'WAYLAND_DISPLAY=' '{print $2}' | awk NF";
      wrapper = name: op:
        pkgs.writeScript "${name}" ''
          if [ "$(${get-wayland-display})" ${op} "$WAYLAND_DISPLAY" ]; then
            exec "$@"
          fi
        '';

      only-on-session = wrapper "only-on-session" "=";
      modulated-wallpaper = pkgs.runCommand "modulated-wallpaper.png" {} ''
        ${lib.getExe pkgs.imagemagick} ${config.stylix.image} -modulate 100,100,14 $out
      '';
    in [
      # {
      #   command = [
      #     "${only-on-session}"
      #     "${lib.getExe pkgs.gammastep}"
      #     "-l"
      #     "59:11" # lol, doxxed
      #   ];
      # }
      {
        command = [
          "${lib.getExe pkgs.waybar}"
        ];
      }
      {
        command = [
          "${lib.getExe pkgs.swaybg}"
          "--mode"
          "fill"
          "--image"
          "${config.stylix.image}"
        ];
      }
      {
        command = let
          units = [
            "niri"
            "graphical-session.target"
            "xdg-desktop-portal"
            "xdg-desktop-portal-gnome"
          ];
          commands = builtins.concatStringsSep ";" (map (unit: "systemctl --user status ${unit}") units);
        in ["rio" "--" "sh" "-c" "env SYSTEMD_COLORS=1 watch -n 1 -d --color '${commands}'"];
      }
      # {command = ["${only-without-session}" "rio" "--" "sh" "-c" "${lib.getExe pkgs.wayvnc} -L=debug"];}

      {command = ["firefox"];}
      {command = ["element-desktop"];}
      {command = ["webcord"];}
      {command = ["telegram-desktop"];}
      {command = ["thunderbird"];}
      # TODO: add idel lock
      # {command = [
      #     "bash"
      #     "-c"
      #     "swayidle -w timeout 300 'swaylock -f --image ~/Pictures/wallpaper-master/nixos.png --clock' before-sleep 'swaylock -f --image ~/Pictures/wallpaper-master/nixos.png --clock' lock 'swaylock -f --image ~/Pictures/wallpaper-master/nixos.png --clock'"
      #   ];
      # }
      # TODO: add applets
      # {command = ["bash" "-c" "nm-applet" "&"];}
      # {command = ["bash" "-c" "blueman-applet" "&"];}
      #{ command = [ "bash" "-c" "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP &" ]; }

      # {command = ["bash" "-c" "export" "$(dbus-launch)"];} # TODO: Figure out what this does. Why do did I put these here?

      # {command = ["bash" "-c" "kdeconnect-indicator" "&"];}
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

    animations.shaders.window-resize = ''
      vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
      }
    '';

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%s.png";

    binds = with config.lib.niri.actions;
    #defaultKeyBind //
      {
        # "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Alt+Return".action.spawn = "rio";
        "Alt+Shift+Return".action.spawn = "kickoff";

        # "Alt+L".action.spawn = ["swaylock" "-f" "--image" "~/Pictures/wallpaper-master/nixos.png" "--clock"];
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "-c" "backlight" "set" "10%-"];

        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "-c" "backlight" "set" "10%+"];

        # Everything regarding windows
        "Alt+Shift+C".action = close-window;
        "Alt+H".action = focus-column-left;
        "Alt+L".action = focus-column-right;
        "Alt+K".action = focus-window-up;
        "Alt+J".action = focus-window-down;
        "Alt+Shift+H".action = move-column-left;
        "Alt+Shift+L".action = move-column-right;
        "Alt+Shift+K".action = move-window-up;
        "Alt+Shift+J".action = move-window-down;

        # Workspaces and monitors
        "Mod+K".action = focus-workspace-up;
        "Mod+J".action = focus-workspace-down;
        "Mod+Shift+K".action = move-window-to-workspace-up;
        "Mod+Shift+J".action = move-window-to-workspace-down;
        "Mod+Ctrl+K".action = move-column-to-workspace-up;
        "Mod+Ctrl+J".action = move-column-to-workspace-down;
        "Alt+Ctrl+K".action = move-workspace-up;
        "Alt+Ctrl+J".action = move-workspace-down;
        "Alt+Ctrl+H".action = focus-monitor-left;
        "Alt+Ctrl+L".action = focus-monitor-right;
        "Alt+Shift+Ctrl+H".action = move-window-to-monitor-left;
        "Alt+Shift+Ctrl+L".action = move-window-to-monitor-right;
        "Mod+Alt+Shift+H".action = move-column-to-monitor-left;
        "Mod+Alt+Shift+L".action = move-column-to-monitor-right;
        "Alt+1".action = focus-workspace 1;
        "Alt+2".action = focus-workspace 2;
        "Alt+3".action = focus-workspace 3;
        "Alt+4".action = focus-workspace 4;
        "Alt+5".action = focus-workspace 5;
        "Alt+6".action = focus-workspace 6;
        "Alt+7".action = focus-workspace 7;
        "Alt+8".action = focus-workspace 8;
        "Alt+9".action = focus-workspace 9;
        "Alt+Shift+1".action = move-column-to-workspace 1;
        "Alt+Shift+2".action = move-column-to-workspace 2;
        "Alt+Shift+3".action = move-column-to-workspace 3;
        "Alt+Shift+4".action = move-column-to-workspace 4;
        "Alt+Shift+5".action = move-column-to-workspace 5;
        "Alt+Shift+6".action = move-column-to-workspace 6;
        "Alt+Shift+7".action = move-column-to-workspace 7;
        "Alt+Shift+8".action = move-column-to-workspace 8;
        "Alt+Shift+9".action = move-column-to-workspace 9;
        "Alt+Ctrl+1".action = move-window-to-workspace 1;
        "Alt+Ctrl+2".action = move-window-to-workspace 2;
        "Alt+Ctrl+3".action = move-window-to-workspace 3;
        "Alt+Ctrl+4".action = move-window-to-workspace 4;
        "Alt+Ctrl+5".action = move-window-to-workspace 5;
        "Alt+Ctrl+6".action = move-window-to-workspace 6;
        "Alt+Ctrl+7".action = move-window-to-workspace 7;
        "Alt+Ctrl+8".action = move-window-to-workspace 8;
        "Alt+Ctrl+9".action = move-window-to-workspace 9;

        # Column and Window stuff
        "Alt+Comma".action = consume-window-into-column;
        "Alt+Period".action = expel-window-from-column;
        "Alt+R".action = switch-preset-column-width;
        "Alt+Shift+R".action = reset-window-height;
        "Alt+Space".action = fullscreen-window;
        "Alt+Shift+Space".action = maximize-column;
        "Alt+C".action = center-column;
        "Alt+Plus".action = set-column-width "+10%";
        "Alt+Equal".action = set-column-width "+10%";
        "Alt+Minus".action = set-column-width "-10%";
        "Mod+Plus".action = set-window-height "+10%";
        "Mod+Equal".action = set-window-height "+10%";
        "Mod+Minus".action = set-window-height "-10%";

        # Screenshots, Monitor off and Exit
        "Alt+Shift+Q".action = quit;
        "Alt+Shift+P".action = power-off-monitors;
        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
      };
  };
}
