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
        package = pkgs.lib.mkForce pkgs.libsForQt5.sddm;
        extraPackages = pkgs.lib.mkForce [];
        theme = "sddm-sugar-candy-nix";
      };
    };
  };
}
