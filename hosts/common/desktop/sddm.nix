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
        package = pkgs.libsForQt5.sddm;
      };
    };
  };
}
