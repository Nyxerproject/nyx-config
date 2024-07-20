{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Polkit agent
    kdePackages.polkit-kde-agent-1

    # Instant messaging packages # TODO consider moving to home. shouldn't be on every desktop and user
    webcord
    tdesktop
    element-desktop
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
