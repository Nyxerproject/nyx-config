{
#   # this is such a fucked up way of doing this lmaoooooo
#   config,
#   lib,
#   pkgs,
#   ...
# }: let
#   inherit
#     (lib)
#     mkEnableOption
#     mkPackageOption
#     mkOption
#     mkIf
#     ;
#   tomlFormat = pkgs.formats.toml {};
# in {
#   options.programs.iamb = {
#     enable = mkEnableOption "iamb";
#
#     package = mkPackageOption pkgs "iamb" {};
#
#     settings = mkOption {
#       inherit (tomlFormat) type;
#       default = {};
#     };
#   };
#   config = mkIf config.programs.iamb.enable {
#     packages = [config.programs.iamb.package];
#
#     xdg.configFile = {
#       "iamb/config.toml" = mkIf (config.programs.iamb.settings != {}) {
#         source = tomlFormat.generate "iamb-app" config.programs.iamb.settings;
#       };
#     };
#   };
}
