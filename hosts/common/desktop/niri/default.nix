{pkgs, ...}: {
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
    ];
  };
  programs.niri.enable = true;
}
