{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; let
      RStudio-for-stats = pkgs.rstudioWrapper.override {
        packages = with pkgs.rPackages; [
          #insert packages here
          ggplot2
        ];
      };
    in [
      RStudio-for-stats
      rPackages.rmarkdown
      pandoc
      texlive
    ];
  };
}
