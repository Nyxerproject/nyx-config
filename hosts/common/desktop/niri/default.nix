{
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
      niri
      fuzzel # niri defaults
      alacritty # niri defaults
      xwayland-satellite
    ];
  };
  programs.niri.enable = true;
}
