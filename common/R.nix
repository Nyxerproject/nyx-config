{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; let
      # https://wiki.nixos.org/wiki/R
      # RStudio-for-stats' = pkgs.rstudioWrapper.override {
      #   packages = with pkgs.rPackages; [];
      # };
      RStudio-for-stats = pkgs.rstudioWrapper.overrideAttrs (oldAttrs: {
        #RStudio-for-stats = RStudio-for-stats'.overrideAttrs (oldAttrs: {
        patches =
          (oldAttrs.patches or [])
          ++ [
            (fetchurl {
              name = "fix.patch";
              url = "https://github.com/NixOS/nixpkgs/commit/5d57a90e2abf555de084876009bffba7dc40f0f2.patch";
              hash = "sha256-fHCSloBiofsXi9JtbEPVGTBBJ3ZikgWdDy5NCFZW5vY=";
            })
          ];
      });
    in [
      #RStudio-for-stats
      rPackages.rmarkdown
    ];
  };
}
