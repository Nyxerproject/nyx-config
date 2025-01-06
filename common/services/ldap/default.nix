{config, ...}: {
  shb.ldap = {
    enable = true;
    domain = "nyxer.xyz";
    subdomain = "ldap";
    ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
    ldapPort = 3890;
    webUIListenPort = 17170;
    dcdomain = "dc=nyxer,dc=xyz";
    ldapUserPassword.result = config.shb.sops.secrets."ldap/userPassword".result;
    jwtSecret.result = config.shb.sops.secrets."ldap/jwtSecret".result;
  };

  shb.certs.certs.letsencrypt."nyxer.xyz".extraDomains = ["ldap.nyxer.xyz"];

  shb.sops.secrets."ldap/userPassword".request = config.shb.ldap.userPassword.request;
  shb.sops.secrets."ldap/jwtSecret".request = config.shb.ldap.jwtSecret.request;
}
