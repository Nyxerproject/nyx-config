{
  lib,
  pkgs,
  ...
}: {
  services = {
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "nyx";
      sddm = {
        enable = lib.mkDefault true;
        wayland.enable = true;
        #package = pkgs.lib.mkForce pkgs.libsForQt5.sddm; # TODO: check this isn't needed anymore for bottom
        extraPackages = pkgs.lib.mkForce [];
        theme = "sddm-sugar-candy-nix";
      };
    };
  };
}
