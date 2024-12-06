{pkgs, ...}: {
  imports = [
    ../alacritty
    ../rio
    ../pkm
    ./niri
  ];

  home = {
    # TODO: cleanup
    packages = with pkgs; [
      # Instant messaging packages
      webcord # discord client
      dissent # discord client
      tdesktop # telegram client
      tgt # telegram tui
      element-desktop # matrix client
      iamb # matrix tui client

      pwvucontrol # audio control
      helvum # more audio control
      coppwr # pipewire control

      # necessary stuff
      firefox # TODO: make this a seporate file and declarative
      thunderbird # TODO: put elseware
    ];
  };
}
