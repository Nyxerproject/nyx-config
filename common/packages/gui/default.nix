{pkgs, ...}: {
  home-manager.users.nyx.imports = [
    ./browsers
    ./terminals
    ./communications
  ];
  home-manager.users.nyx.home.packages = with pkgs; [];
  environment = {
    systemPackages = with pkgs; [
      zed-editor
      lapce

      # terminal emulators
      rio
      foot
      kitty
      wezterm
      waveterm

      # audio
      qpwgraph
      pwvucontrol # audio control
      helvum # more audio control
      coppwr # pipewire control

      # tools
      qbittorrent
      keepassxc

      gparted
      corectrl

      vlc # video player
      foliate # epub reader
      rnote # handwritten notes
      spacedrive
      celeste
      inlyne

      prusa-slicer
      obs-studio
      planify
      nautilus
      androidenv.androidPkgs.androidsdk # android stuff lol
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
