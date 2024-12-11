{pkgs, ...}: {
  imports = [
    ../alacritty
    ../rio
    ../pkm
    ./niri
    ./firefox
    ./utilities
    ./chats
  ];
}
