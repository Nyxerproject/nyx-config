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
        ];
      };
    in [
      # RStudio-for-stats
      rPackages.rmarkdown
    ];
  };
}
