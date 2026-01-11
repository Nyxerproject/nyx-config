{ pkgs, ... }:
{
  imports = [ ./terminals ];
  home-manager.users.nyx.imports = [
    ./browsers
    ./communications
  ];
  home-manager.users.nyx.home.packages = with pkgs; [ ];
  environment = {
    systemPackages = with pkgs; [
      # kicad
      # kicadAddons.kikit
      # kicadAddons.kikit-library
      # kikit

      # terminal emulators
      # wezterm
      # waveterm

      lapce

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

      # prusa-slicer
      obs-studio
      nautilus

      obsidian
      appflowy
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
