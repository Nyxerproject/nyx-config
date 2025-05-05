{config, ...}: let
  domain = "nyxer.xyz";
in {
  shb.certs = {
    certs = {
      letsencrypt."${domain}" = {
        domain = "${domain}";
        group = "nginx";
        reloadServices = ["nginx.service"];
        adminEmail = "nxyerproject@gmail.com";
        extraDomains = [
          "nextcloud.${domain}"
          "ldap.${domain}"
          "forgejo.${domain}"
          "auth.${domain}"
          "octoprint.${domain}"
        ];
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    certs."nextcloud.${domain}".email = "nxyerproject@gmail.com";
    certs."ldap.${domain}".email = "nxyerproject@gmail.com";
    certs."forgejo.${domain}".email = "nxyerproject@gmail.com";
    certs."auth.${domain}".email = "nxyerproject@gmail.com";
    certs."octoprint.${domain}".email = "nxyerproject@gmail.com";

    defaults.email = "nxyerproject@gmail.com";
  };
}
