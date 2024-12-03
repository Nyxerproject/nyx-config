{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./notifications
    ../kickoff
    ./lan-mouse
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      brightnessctl
      gamescope
      cage
      ddcutil
      xwayland-run
      xwayland-satellite-unstable
      wvkbd

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
