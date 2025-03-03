{pkgs, ...}: {
  home-manager.users.nyx.imports = [
    ./browsers
    ./terminals
    ./communications
  ];

  home-manager.users.nyx.home.packages = [];
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
      keepassxc
      gparted
      qbittorrent

      vlc # video player
      foliate # epub reader
      rnote # handwritten notes
      spacedrive

      prusa-slicer
      obs-studio
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
