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

      # portals
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      gnome.gnome-keyring
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
