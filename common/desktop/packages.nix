{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".default

    # terminal emulators
    foot
    kitty
    wezterm
    waveterm

    # copy paste stuff
    wl-clipboard

    # audio
    qpwgraph

    # tools
    gparted
    keepassxc
    qbittorrent

    vlc # video player
    foliate # epub reader
    rnote # handwritten notes
    spacedrive

    obs-studio
  ];

  services.mullvad-vpn.enable = true;
}
