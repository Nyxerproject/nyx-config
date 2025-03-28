{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; let
      RStudio-for-stats = pkgs.rstudioWrapper.override {packages = [pkgs.rPackages.ggplot2];};
    in [
      RStudio-for-stats
      rPackages.rmarkdown
      tectonic # latex compiler
      texliveMedium
    ];
  };
}
