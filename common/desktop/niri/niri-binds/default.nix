{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Alt+Shift+Slash".action = show-hotkey-overlay;
    "Alt+Return".action.spawn = lib.getExe pkgs.rio;
    "Alt+Shift+Return".action.spawn = lib.getExe pkgs.kickoff;

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
    # "Alt+Ctrl+1".action = move-window-to-workspace 1;
    # "Alt+Ctrl+2".action = move-window-to-workspace 2;
    # "Alt+Ctrl+3".action = move-window-to-workspace 3;
    # "Alt+Ctrl+4".action = move-window-to-workspace 4;
    # "Alt+Ctrl+5".action = move-window-to-workspace 5;
    # "Alt+Ctrl+6".action = move-window-to-workspace 6;
    # "Alt+Ctrl+7".action = move-window-to-workspace 7;
    # "Alt+Ctrl+8".action = move-window-to-workspace 8;
    # "Alt+Ctrl+9".action = move-window-to-workspace 9;

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
    # "Ctrl+Print".action = screenshot-screen;
    # "Alt+Print".action = screenshot-window;
  };
}
