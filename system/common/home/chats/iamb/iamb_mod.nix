{
  # this is such a fucked up way of doing this lmaoooooo
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    mkIf
    ;
  cfg = config.programs.iamb;
  tomlFormat = pkgs.formats.toml {};
in {
  meta.maintainers = with lib.hm.maintainers; [nyxerproject];
  #meta.maintainers = with lib.hm.maintainers; [_71zenith];
  # should I replace this?.
  options.programs.iamb = {
    enable = mkEnableOption "iamb";

    package = mkPackageOption pkgs "iamb" {};

    settings = mkOption {
      inherit (tomlFormat) type;
      default = {};
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile = {
      "iamb/config.toml" = mkIf (cfg.settings != {}) {
        source = tomlFormat.generate "iamb-app" cfg.settings;
      };
    };
  };
}
