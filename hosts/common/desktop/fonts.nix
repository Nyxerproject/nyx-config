{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      fira-code
      roboto
      gohufont
    ];

    enableDefaultPackages = true;

    fontDir = {
      enable = true;
      decompressFonts = true;
    }; #https://general-metrics.com/articles/nixos-nerd-fonts/
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        serif = ["hack-font"];
        sansSerif = ["hack-font"];
        monospace = ["hack-font"];
      };
    };
  };
}
