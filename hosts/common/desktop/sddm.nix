{
  lib,
  pkgs,
  ...
}: {
  services = {
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "nyx";
      sddm = {
        enable = true;
        wayland.enable = true;
        #package = pkgs.lib.mkForce pkgs.libsForQt5.sddm; # TODO: check this isn't needed anymore for bottom
        extraPackages = pkgs.lib.mkForce [];
        theme = "sddm-sugar-candy-nix";
      };
    };
  };
}
