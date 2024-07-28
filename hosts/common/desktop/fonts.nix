{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      hack-font
      noto-fonts-cjk-sans
      fira
      monocraft
      fira-code
      roboto
      gohufont
    ];

    enableDefaultPackages = true;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

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
