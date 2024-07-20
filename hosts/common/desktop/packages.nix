{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Instant messaging packages
    webcord
    tdesktop
    element-desktop
    element-desktop-wayland
    iamb

    # copy paste stuff
    wl-clipboard
    # audio
    qpwgraph
  ];
}
