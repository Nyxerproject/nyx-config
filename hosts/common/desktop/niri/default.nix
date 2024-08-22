{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./notifications
    ./fuzzel.nix
  ];
  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      fuzzel # niri defaults
      alacritty # niri defaults
      gamescope
      cage
      xwayland-run
    ];
  };
  programs = {
    xwayland = {
      enable = true;
    };
    niri = {
      package = pkgs.niri-unstable;
      enable = true;
    };
  };
  niri-flake.cache.enable = true;
  nixpkgs = {
    overlays = [
      inputs.niri.overlays.niri
    ];
  };
}
