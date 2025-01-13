{
  networking.hostName = "top";

  services.xserver.enable = false;

  networking = {
    # interfaces.enp0s13f0u2u2c2 = {
    #   ipv6.addresses = [
    #     {
    #       address = "2605:4a80:b400:6010:7e4b:6130:522f:d55a";
    #       prefixLength = 64;
    #     }
    #   ];
    #   ipv4.addresses = [
    #     {
    #       address = "192.0.2.2";
    #       prefixLength = 24;
    #     }
    #   ];
    # };
    # defaultGateway = {
    #   address = "192.0.2.1";
    #   interface = "enp0s13f0u2u2c2";
    # };
    # defaultGateway6 = {
    #   address = "fe80::1";
    #   interface = "enp0s13f0u2u2c2";
    # };
  };
  system.stateVersion = "24.05";
}
