{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global
  ];
  programs.alacritty.enable = true;
}
