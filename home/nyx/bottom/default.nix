{inputs, ...}: {
  imports = [
    ../global
    ../features/desktop
    ../features/games/gaming.nix
    ../features/vr
    ../features
    ./niri-monitors.nix
    ./niri.nix
    # ./hyprland.nix
  ];
}
