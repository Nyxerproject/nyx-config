{inputs, ...}: {
  imports = [
    ../global
    ../features/games/gaming.nix
    ../features/vr
    ./niri-monitors.nix
    ./niri.nix
    # ../../../hosts/common/desktop/niri/niri.nix
  ];
}
