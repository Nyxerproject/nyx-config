{config, ...}: {
  shb.certs = {
    # cas.selfsigned.nyxerproject_vpn_ca = {
    #   name = "nyxerproject_vpn_ca";
    #   #cert = "/var/lib/certs/cas/nyx_vpn.cert";
    #   #key = "/var/lib/certs/cas/nyx_vpn.key";
    # };
    certs = {
      # selfsigned = {
      #   "nyx" = {
      #     ca = config.shb.certs.cas.selfsigned.myca;
      #
      #     domain = "nyx";
      #     group = "nginx";
      #     reloadServices = ["nginx.service"];
      #   };
      #   "www.nyx" = {
      #     ca = config.shb.certs.cas.selfsigned.myca;
      #
      #     domain = "www.nyx";
      #     group = "nginx";
      #   };
      letsencrypt."nyxer.xyz" = {
        domain = "nyxer.xyz";
        group = "nginx";
        reloadServices = ["nginx.service"];
        adminEmail = "nyxerproject@gmail.com";
        extraDomains = ["nextcloud.nyxer.xyz"];
      };
    };
  };
}
