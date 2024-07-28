{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./niri.nix
    ./notifications
    ./fuzzel.nix
    inputs.niri-flake.nixosModules.niri
  ];

  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      fuzzel # niri defaults
      alacritty # niri defaults
      xwayland-satellite
      # gamescope
      # xwayland-run
    ];
  };
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  # niri-flake.cache.enable = true;
  nixpkgs = {
    overlays = [
      inputs.niri-flake.overlays.niri
    ];
  };
}
