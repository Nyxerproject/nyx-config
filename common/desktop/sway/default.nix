{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../niri/fuzzel.nix
    ../niri/notifications
  ];

  programs.sway = {enable = true;};

  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      fuzzel # niri defaults
      alacritty # niri defaults
      kitty
    ];
  };
  programs.xwayland = {enable = true;};
}
