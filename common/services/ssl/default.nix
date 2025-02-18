{config, ...}: {
  # shb.certs = {
  #   certs = {
  #     letsencrypt."nyxer.xyz" = {
  #       domain = "nyxer.xyz";
  #       group = "nginx";
  #       reloadServices = ["nginx.service"];
  #       adminEmail = "nxyerproject@gmail.com";
  #       extraDomains = ["nextcloud.nyxer.xyz"];
  #     };
  #   };
  # };
  security.acme = {
    acceptTerms = true;
    certs = {
      ${config.services.nextcloud.hostName}.email = "nxyerproject@gmail.com";
    };
  };
  security.acme.defaults.email = "nxyerproject@gmail.com";
}
