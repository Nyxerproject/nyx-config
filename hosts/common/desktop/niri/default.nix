{pkgs, ...}: {
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
      niri
      xwayland-satellite
      gamescope
      xwayland-run
    ];
  };
  programs.niri.enable = true;
}
