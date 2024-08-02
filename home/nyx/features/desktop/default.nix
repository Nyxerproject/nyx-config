{pkgs, ...}: {
  imports = [
    ../alacritty/default.nix
  ];

  home = {
    # TODO cleanup
    packages = with pkgs; [
      # Instant messaging packages
      # TODO --consider moving to home. shouldn't be on every desktop and user--
      # TODO make sure these work well
      webcord
      tdesktop
      element-desktop-wayland
      iamb

      # keyboard tools
      zmkBATx # TODO shouldn't be here

      # desktop notifications # TODO shouldn't be in home defaults
      libnotify # TODO remove this
      mako

      vulkan-tools
      wayland-utils
      pwvucontrol
      helvum
      coppwr

      # necessary stuff
      firefox # TODO make this a seporate file
    ];
  };
}
