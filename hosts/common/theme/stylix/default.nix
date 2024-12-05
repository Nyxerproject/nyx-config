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
    polarity = "dark";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ./../backgrounds/background.png;
    cursor = {
      name = lib.mkDefault "phinger-cursors-${config.stylix.polarity}";
      package = lib.mkDefault pkgs.phinger-cursors;
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
  };
}
