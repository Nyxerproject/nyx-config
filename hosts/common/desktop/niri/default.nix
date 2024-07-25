{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./notifications
    ./fuzzel.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      niri
      fuzzel # niri defaults
      alacritty # niri defaults
      inputs.xwayland-satellite.packages.x86_64-linux.default
    ];
  };
  programs.niri.enable = true;
}
