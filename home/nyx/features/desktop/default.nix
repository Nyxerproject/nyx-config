{pkgs, ...}: {
  imports = [
    ../alacritty
    ../rio
    ../pkm
    ./niri
  ];

  home = {
    # TODO: cleanup
    packages = with pkgs; [
      # Instant messaging packages
      webcord # discord client
      dissent # discord client
      tdesktop # telegram client
      element-desktop
      iamb

      libnotify

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
      # remmina
      # grimblast
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
