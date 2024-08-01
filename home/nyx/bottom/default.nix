{inputs, ...}: {
  imports = [
    ../global
    ../features/games/gaming.nix
    ../features/desktop
    ../features/vr
    ./niri-monitors.nix
    ./niri.nix
  ];
}
