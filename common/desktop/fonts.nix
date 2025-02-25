{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      roboto
      gohufont
    ];

    enableDefaultPackages = true;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    # https://general-metrics.com/articles/nixos-nerd-fonts/
    fontconfig.cache32Bit = true;
  };
}
