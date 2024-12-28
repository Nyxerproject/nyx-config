{
  networking.hostName = "charm";

  hardware.opengl.enable = true;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = false;

  system.stateVersion = "24.05";

  # security.wrappers.flatpak = {
  #   owner = "root";
  #   group = "root";
  #   source = "${pkgs.flatpak}/bin/flatpak";
  #   capabilities = "cap_sys_nice-pie";
  # };

  # Enable steam keyboard on wayland ?
  # programs.steam = {
  #   enable = true;
  #   extest.enable = true;
  # };
}
