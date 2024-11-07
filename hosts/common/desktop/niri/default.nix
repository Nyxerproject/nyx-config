{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./notifications
    ./fuzzel.nix
    ./lan-mouse
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      fuzzel # niri defaults
      alacritty # niri defaults
      brightnessctl
      gamescope
      cage
      ddcutil
      xwayland-run
      xwayland-satellite-unstable

      # portals
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      gnome-keyring
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
