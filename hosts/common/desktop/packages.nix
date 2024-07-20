{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Polkit agent
    # TODO move to security dir(?)
    kdePackages.polkit-kde-agent-1

    # Instant messaging packages # TODO consider moving to home. shouldn't be on every desktop and user
    webcord
    tdesktop
    element-desktop-wayland
    iamb
    # copy paste stuff
    wl-clipboard
    # audio
    qpwgraph

    # tools
    gparted
  ];
}
