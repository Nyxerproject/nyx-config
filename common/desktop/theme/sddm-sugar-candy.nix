{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.sddm-sugar-candy-nix.nixosModules.default];
  services = {
    displayManager = {
      sddm = {
        theme = "sddm-sugar-candy-nix";
        sugarCandyNix = {
          enable = true; # set SDDM's theme to "sddm-sugar-candy-nix".
          settings = {
            Background = lib.cleanSource ../../theme/backgrounds/background.png;
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
  nixpkgs.overlays = [inputs.sddm-sugar-candy-nix.overlays.default];
}
