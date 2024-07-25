{
  services = {
    displayManager = {
      autoLogin.enable = false;
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
