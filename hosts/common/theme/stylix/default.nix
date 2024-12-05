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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ./../backgrounds/background.png;
    cursor.name = lib.mkDefault "phinger-cursors-${config.stylix.polarity}";
    cursor.package = lib.mkDefault pkgs.phinger-cursors;
    fonts.monospace.name = lib.mkDefault "Fira Code";
    fonts.monospace.package = pkgs.nerd-fonts.fira-code;
  };
}
