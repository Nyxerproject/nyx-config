{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      pwvucontrol # audio control
      helvum # more audio control
      coppwr # pipewire control
    ];
  };
}
