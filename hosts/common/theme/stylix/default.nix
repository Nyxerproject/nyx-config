{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./../backgrounds/background.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    opacity = {
      terminal = 0.75;
      popups = 0.9;
    };
    cursor = {
      name = lib.mkDefault "phinger-cursors-${config.stylix.polarity}";
      package = lib.mkDefault pkgs.phinger-cursors;
      size = 12;
    };
    fonts = {
      serif = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets.grub.useImage = true;
  };
}
