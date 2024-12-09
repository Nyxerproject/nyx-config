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

  # TODO: cleanup
  home = {
    packages = with pkgs; [
      pwvucontrol # audio control
      helvum # more audio control
      coppwr # pipewire control
    ];
  };
}
