{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; let
      RStudio-for-stats = pkgs.rstudioWrapper.override {
        packages = with pkgs; [
          rPackages.ggplot2
          rPackages.tinytex
        ];
      };
    in [
      RStudio-for-stats
      rPackages.rmarkdown
      tectonic # latex compiler
      texliveMedium
      pandoc
    ];
  };
}
