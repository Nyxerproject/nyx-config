{pkgs, ...}: {
  imports = [
    ../alacritty
    ../rio
    ../pkm
    ./niri
    ./firefox
    ./browsers
    ./utilities
    ./chats
  ];
}
