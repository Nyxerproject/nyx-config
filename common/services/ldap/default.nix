{config, ...}: {
  shb = {
    #   ldap = {
    #     enable = false;
    #     domain = "nyxer.xyz";
    #     subdomain = "ldap";
    #     ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
    #     ldapPort = 3890;
    #     webUIListenPort = 17170;
    #     dcdomain = "dc=nyxer,dc=xyz";
    #     ldapUserPassword.result = config.shb.sops.secret."ldap/userPassword".result;
    #     jwtSecret.result = config.shb.sops.secret."ldap/jwtSecret".result;
    #   };
    #
    #   certs.certs.letsencrypt."nyxer.xyz".extraDomains = ["ldap.nyxer.xyz"];
    #
    #   sops.secret = {
    #     "ldap/userPassword".request = config.shb.ldap.ldapUserPassword.request;
    #     "ldap/jwtSecret".request = config.shb.ldap.jwtSecret.request;
    #   };
  };
}
