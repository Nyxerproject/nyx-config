{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # webcord-vencord # discord client w/ swag
    telegram-desktop
    signal-desktop
    # webcord # discord client
    element-desktop # matrix client
  ];
}
