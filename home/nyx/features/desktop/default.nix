{pkgs, ...}: {
  imports = [
    ../alacritty
    ../rio
    ../pkm
    ./niri
    ./firefox
  ];

  # TODO: cleanup
  home = {
    packages = with pkgs; [
      pwvucontrol # audio control
      helvum # more audio control
      coppwr # pipewire control

      # necessary stuff
      thunderbird # TODO: put elseware
    ];
  };
}
