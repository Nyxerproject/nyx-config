{inputs, ...}: {
  imports = [
    ../global
    ../features/desktop
    ../features/games/gaming.nix
    ../features/vr
    ./niri-monitors.nix
    ./niri.nix
  ];
}
