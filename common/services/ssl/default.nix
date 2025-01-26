{config, ...}: {
  shb.certs = {
    # cas.selfsigned.nyxerproject_vpn_ca = {
    #   name = "nyxerproject_vpn_ca";
    #   cert = "/var/lib/certs/cas/nyx_vpn.cert";
    #   key = "/var/lib/certs/cas/nyx_vpn.key"; # TODO: add to persist
    # };
    certs = {
      # selfsigned = {
      #   "nyxer.xyz" = {
      #     ca = config.shb.certs.cas.selfsigned.nyxerproject_vpn_ca;
      #
      #     domain = "nyxer.xyz";
      #     group = "nginx";
      #     reloadServices = ["nginx.service"];
      #   };
      # };
      letsencrypt."nyxer.xyz" = {
        domain = "nyxer.xyz";
        group = "nginx";
        reloadServices = ["nginx.service"];
        adminEmail = "nxyerproject@gmail.com";
        extraDomains = ["nextcloud.nyxer.xyz"];
      };
    };
  };
  security.acme.defaults.email = "nxyerproject@gmail.com";
}
