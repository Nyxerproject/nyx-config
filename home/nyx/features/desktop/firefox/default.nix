# stollen from here https://github.com/Lichthagel/nix-config/blob/ca190b4500d4f221608c679f42ccb09d019c05fb/home/programs/firefox/default.nix
{
  config,
  lib,
  ...
}: let
  cfg = config.programs.firefox.nyx;
in {
  options.programs.firefox.nyx = {
    enable = lib.mkEnableOption "my firefox config";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        # settings = builtins.import ./settings.nix;
        # TODO: read the settings i have here. idk what they are and I stole them from other ppl in a hurry
      };
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
