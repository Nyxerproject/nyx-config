{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; let
      # https://wiki.nixos.org/wiki/R
      RStudio-for-stats = pkgs.rstudioWrapper.override {packages = with pkgs.rPackages; [];};
    in [
      RStudio-for-stats
      rPackages.rmarkdown
    ];
  };
}
