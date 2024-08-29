{
  services = {
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "nyx";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
