{pkgs, ...}: {
  programs.command-not-found.enable = true;

  environment.systemPackages = with pkgs; [
    # Polkit agent
    # TODO move to security dir(?)
    # TODO this isn't how you start polkit agents lmao. commenting out for now
    #kdePackages.polkit-kde-agent-1

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
  ];
}
