{pkgs, ...}: {
  imports = [
    # ./vr
    # ./gaming.nix
    # ./mullvad.nix
  ];

  environment.systemPackages = with pkgs; [
    qpwgraph
    webcord
    element-desktop
    tdesktop
    wl-clipboard
  ];

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
