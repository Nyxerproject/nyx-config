{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./niri.nix
    ./notifications
    ./fuzzel.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      fuzzel # niri defaults
      alacritty # niri defaults
      xwayland-satellite
      niri-unstable
      gamescope
      cage
      xwayland-run
    ];
  };
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  niri-flake.cache.enable = true;
  nixpkgs = {
    overlays = [
      inputs.niri.overlays.niri
    ];
  };
}
