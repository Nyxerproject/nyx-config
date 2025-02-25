{lib, ...}: {
  services = {
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "nyx";
      sddm = {
        enable = lib.mkDefault true;
        wayland.enable = true;
        theme = "sddm-sugar-candy-nix";
      };
    };
  };
}
