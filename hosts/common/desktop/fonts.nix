{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      hack-font
      noto-fonts-cjk-sans
      fira
      monocraft
      fira-code
      roboto
    ];

    enableDefaultPackages = true;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        sansSerif = ["hack-font"];
        monospace = ["hack-font"];
      };
    };
  };
}