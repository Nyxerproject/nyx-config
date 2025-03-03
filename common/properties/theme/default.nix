{
  lib,
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./background.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/pasque.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    opacity = {
      terminal = 0.9;
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
        name = "FiraCodeNerdFont";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCodeNerdFont";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCodeNerdFont";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets.grub.useImage = true;
  };
  services = {
    displayManager = {
      sddm = {
        theme = "sddm-sugar-candy-nix";
        sugarCandyNix = {
          enable = true; # set SDDM's theme to "sddm-sugar-candy-nix".
          settings = {
            Background = lib.cleanSource ./background.png;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
          };
        };
      };
    };
  };
}
