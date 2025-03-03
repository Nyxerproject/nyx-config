{pkgs, ...}: {
  imports = [];
  home-manager.users.nyx.imports = [
    # ./wluma.nix
    ./waybar.nix
    ./swaync_mod.nix
    ./swaync.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      kickoff
      networkmanagerapplet

      brightnessctl
      ddcutil

      wayland-utils
      wl-clipboard
      wvkbd

      libsecret
    ];
  };
}
