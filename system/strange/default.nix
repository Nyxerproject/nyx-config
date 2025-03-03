{
  imports = [
    # ./configuration.nix
    {
      networking.hostName = "strange";
      services.xserver.enable = false;
      system.stateVersion = "24.05";
    }
    ../../users/nyx.nix

    ../../common
    ../../common/properties/wsl
  ];
}
