{pkgs, ...}: {
  imports = [
    ../alacritty
    ../pkm
    ./niri
  ];

  home = {
    # TODO: cleanup
    packages = with pkgs; [
      # Instant messaging packages
      # TODO: --consider moving to home. shouldn't be on every desktop and user--
      # TODO: make sure these work well
      webcord
      tdesktop
      # element-desktop # only one should be added. otherwise there will be a colision
      element-desktop-wayland
      kdePackages.neochat
      iamb

      # keyboard tools
      zmkBATx # TODO: shouldn't be here

      lazygit
      # wofi
      # clipman
      # wl-clipboard
      # foliate
      # espeak
      # distrobox
      # xq
      # signal-desktop
      # remmina
      # firefox-wayland
      # grimblast
      # nixd
      # vial
      # anki-bin

      vulkan-tools
      wayland-utils
      pwvucontrol
      helvum
      coppwr

      # necessary stuff
      firefox # TODO: make this a seporate file
      thunderbird
    ];
  };
}
