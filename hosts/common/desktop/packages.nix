{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Polkit agent
    # TODO move to security dir(?)
    # TODO this isn't how you start polkit agents lmao. commenting out for now
    #kdePackages.polkit-kde-agent-1

    # terminal emulators
    rio
    #alacritty # this is declared everywhere so it is commented out

    # copy paste stuff
    wl-clipboard

    # audio
    qpwgraph

    # tools
    gparted
    keepassxc
    qbittorrent
  ];
}
