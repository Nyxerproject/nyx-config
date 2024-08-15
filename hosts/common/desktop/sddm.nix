{
  services = {
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "nyx";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
