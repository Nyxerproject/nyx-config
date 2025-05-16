{pkgs, ...}: {
  environment.systemPackages = with pkgs; let
    RStudio-for-stats = pkgs.rstudioWrapper.override {
      packages = with pkgs; [
        rPackages.ggplot2
        rPackages.tinytex
        rPackages.rmarkdown
      ];
    };
  in [
    RStudio-for-stats
    tectonic # latex compiler
    texliveFull
    pandoc
  ];
}
